class Task
  attr_reader(:description, :list_id, :due_date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @due_date = attributes.fetch(:due_date)
    @list_id = attributes[:list_id]
  end

  define_singleton_method(:all) do |list_id|
    if list_id
      find_string = "SELECT * FROM tasks WHERE list_id = #{list_id} ORDER BY due_date ASC;"
    else
      find_string = "SELECT * FROM tasks WHERE list_id is NULL ORDER BY due_date ASC;"
    end
    returned_tasks = DB.exec(find_string)
    tasks = []
    returned_tasks.each do |task|
      description = task.fetch("description")
      list_id = task.fetch('list_id').to_i()
      due_date = task.fetch('due_date')
      tasks.push(Task.new({description: description, list_id: list_id, due_date: due_date}))
    end
    tasks
  end

  define_method(:save) do
    if @list_id
      save_string = "INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}');"
    else
      save_string = "INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', null, '#{@due_date}');"
    end
    DB.exec(save_string)
  end

  define_method(:==) do |other_task|
    self.list_id().to_i() == other_task.list_id().to_i() && self.description() == other_task.description()
  end
end
