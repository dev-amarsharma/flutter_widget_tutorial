# Room Database

## Overview
Room is the recommended persistence library for Android. It is an abstraction layer over SQLite that gives you compile-time verified SQL, less boilerplate, and smooth integration with coroutines and `Flow`.

A Room database is built from three components:

- an `@Entity` that defines a table
- a `@Dao` that defines how you read and write that data
- a `@Database` class that ties the entities and DAOs together

Android's official docs describe Room as the recommended approach for storing structured, local data on the device.

## Adding the dependency
Room ships as a runtime library plus an annotation processor. With Kotlin, use KSP:

```kotlin
plugins {
  id("com.google.devtools.ksp")
}

dependencies {
  val room = "2.6.1"
  implementation("androidx.room:room-runtime:$room")
  implementation("androidx.room:room-ktx:$room")
  ksp("androidx.room:room-compiler:$room")
}
```

The `room-ktx` artifact adds coroutine and `Flow` support.

## The three building blocks
First define an entity (a table):

```kotlin
@Entity
data class User(
  @PrimaryKey(autoGenerate = true) val id: Int = 0,
  val name: String
)
```

Then a DAO (how you access the table):

```kotlin
@Dao
interface UserDao {
  @Query("SELECT * FROM User")
  fun getAll(): Flow<List<User>>

  @Insert
  suspend fun insert(user: User)
}
```

Finally the database class that wires them together:

```kotlin
@Database(entities = [User::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
  abstract fun userDao(): UserDao
}
```

## Building the database
Create a single instance and reuse it for the whole app, because building a database is expensive:

```kotlin
val db = Room.databaseBuilder(
  context,
  AppDatabase::class.java,
  "app-database"
).build()

val userDao = db.userDao()
```

A common pattern is to expose this single instance through a dependency injection framework such as Hilt, or via a manually managed singleton.

## Running off the main thread
Room blocks queries on the main thread by default to keep the UI responsive. Use `suspend` functions or return a reactive type like `Flow` so reads and writes run on a background dispatcher:

```kotlin
suspend fun addUser(dao: UserDao) {
  dao.insert(User(name = "Ada"))
}
```

Returning `Flow` also means the UI automatically re-emits whenever the underlying table changes.

## Migrations
When you change the schema, increase the `version` and provide a `Migration` so existing user data is preserved:

```kotlin
val MIGRATION_1_2 = object : Migration(1, 2) {
  override fun migrate(db: SupportSQLiteDatabase) {
    db.execSQL("ALTER TABLE User ADD COLUMN age INTEGER NOT NULL DEFAULT 0")
  }
}
```

Avoid `fallbackToDestructiveMigration()` in production, since it wipes stored data.

## Best practices
- Keep a single `RoomDatabase` instance for the whole app.
- Use `suspend` functions or `Flow` so database work never blocks the UI thread.
- Provide explicit migrations instead of destroying data on schema changes.
- Keep entities focused on persistence and put access logic in DAOs.

## Common mistakes
- Building a new database instance on every screen or request.
- Running queries on the main thread and freezing the UI.
- Shipping destructive migrations that silently delete user data.
- Forgetting to bump the schema `version` after changing an entity.

## References
- Room overview: https://developer.android.com/training/data-storage/room
- Defining data using Room entities: https://developer.android.com/training/data-storage/room/defining-data
- Migrating Room databases: https://developer.android.com/training/data-storage/room/migrating-db-versions
