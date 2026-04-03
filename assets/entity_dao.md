# Room Entity and DAO

## Overview
In Room, entities and DAOs are foundational concepts.

- an `@Entity` defines a table
- a DAO, or Data Access Object, defines how your app reads and writes that data

Android’s Room docs recommend using DAOs to access your app’s persisted data rather than writing raw database access directly throughout the app.

## Entity
An entity usually maps to a table:

```kotlin
@Entity
data class User(
  @PrimaryKey val id: Int,
  val name: String
)
```

This tells Room how to store rows for `User`.

## DAO
A DAO is an interface or abstract class annotated with `@Dao`:

```kotlin
@Dao
interface UserDao {
  @Query("SELECT * FROM User")
  fun getAll(): Flow<List<User>>

  @Insert
  suspend fun insert(user: User)
}
```

DAOs commonly use:

- `@Query`
- `@Insert`
- `@Update`
- `@Delete`

## Why DAOs matter
DAOs centralize data access logic and make it easier to:

- keep SQL in one place
- test data-layer behavior
- expose reactive query results such as `Flow`

## Best practices
- Keep entity definitions focused on persistence structure.
- Put database access behind DAOs.
- Use suspend functions or reactive streams where appropriate.
- Keep SQL readable and specific.

## Common mistakes
- Spreading SQL logic across unrelated classes.
- Treating entities as if they must contain all domain behavior.
- Returning huge unstructured data without modeling query intent.

## References
- Room overview: https://developer.android.com/training/data-storage/room
- Accessing data using Room DAOs: https://developer.android.com/training/data-storage/room/accessing-data
