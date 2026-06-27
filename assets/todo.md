# Build a Todo App

## Overview
This project ties together the core skills of modern Android development: Compose for the UI, a `ViewModel` for state, and Room for local persistence. You will build a small Todo app where tasks are added, toggled complete, deleted, and stored on the device so they survive restarts.

This is a capstone, so it assumes you already understand Compose state, ViewModels, and Room setup.

## Architecture
The app follows a simple unidirectional layered structure:

- **UI (Compose)** renders the task list and sends events up.
- **ViewModel** exposes the list as state and handles user actions.
- **Repository** mediates between the ViewModel and the data layer.
- **Room** stores the tasks in a local database.

State flows down from the database through the ViewModel into the UI; events flow back up.

## 1. The entity
```kotlin
@Entity
data class Task(
  @PrimaryKey(autoGenerate = true) val id: Int = 0,
  val title: String,
  val isDone: Boolean = false
)
```

## 2. The DAO
```kotlin
@Dao
interface TaskDao {
  @Query("SELECT * FROM Task ORDER BY id DESC")
  fun observeAll(): Flow<List<Task>>

  @Insert
  suspend fun insert(task: Task)

  @Update
  suspend fun update(task: Task)

  @Delete
  suspend fun delete(task: Task)
}
```

Returning `Flow` means the UI updates automatically whenever the table changes.

## 3. The database
```kotlin
@Database(entities = [Task::class], version = 1)
abstract class TodoDatabase : RoomDatabase() {
  abstract fun taskDao(): TaskDao
}
```

Build a single instance with `Room.databaseBuilder` and reuse it.

## 4. The ViewModel
```kotlin
class TodoViewModel(private val dao: TaskDao) : ViewModel() {

  val tasks: StateFlow<List<Task>> = dao.observeAll()
    .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())

  fun add(title: String) = viewModelScope.launch {
    dao.insert(Task(title = title))
  }

  fun toggle(task: Task) = viewModelScope.launch {
    dao.update(task.copy(isDone = !task.isDone))
  }

  fun remove(task: Task) = viewModelScope.launch {
    dao.delete(task)
  }
}
```

The database `Flow` is converted into a `StateFlow` the UI can collect, and every action runs in `viewModelScope`.

## 5. The UI
```kotlin
@Composable
fun TodoScreen(viewModel: TodoViewModel) {
  val tasks by viewModel.tasks.collectAsStateWithLifecycle()

  LazyColumn {
    items(tasks, key = { it.id }) { task ->
      Row {
        Checkbox(
          checked = task.isDone,
          onCheckedChange = { viewModel.toggle(task) }
        )
        Text(task.title)
      }
    }
  }
}
```

Add a `TextField` and a button to capture new task titles and call `viewModel.add(...)`.

## Stretch goals
- Show an empty state when there are no tasks.
- Add swipe-to-delete.
- Persist a "show completed" filter.
- Add a due date column with a migration.

## Best practices
- Keep the database as the single source of truth and observe it with `Flow`.
- Do all data work in the ViewModel via `viewModelScope`.
- Keep composables stateless by hoisting state into the ViewModel.
- Provide stable `key`s in lists so Compose recomposes efficiently.

## Common mistakes
- Holding the task list in the UI instead of observing the database.
- Mutating a `Task` in place instead of inserting a `copy`.
- Running database writes on the main thread.
- Forgetting list `key`s, causing unnecessary recomposition.

## References
- Guide to app architecture: https://developer.android.com/topic/architecture
- Save data in a local database using Room: https://developer.android.com/training/data-storage/room
- Lists and grids in Compose: https://developer.android.com/develop/ui/compose/lists
