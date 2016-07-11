require('rspec')
require('pg')
require('task')


DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe('Task') do
  describe("#initialize") do
    it("should return name of newly created Task object") do
      new_task = Task.new({description:'test_description', list_id: 1, due_date: '01/01/2016 00:00:000'})
      expect(new_task.description()).to(eq('test_description'))
    end
  end

  describe('#save') do
    it "should save the newly created Task object into tasks table in DB" do
      new_task = Task.new({description:'test_description', list_id: nil, due_date: '01/01/2016 00:00:000'})
      new_task.save()
      expect(Task.all(nil)).to(eq([new_task]))
    end
  end

  describe('.all') do
    it "should return tasks in ascending due_date order" do
      new_task = Task.new({description:'test_description', list_id: nil, due_date: '01/01/2016 00:00:000'})
      new_task2 = Task.new({description:'test_description', list_id: nil, due_date: '01/01/2016 10:00:000'})
      new_task.save()
      new_task2.save()
      expect(Task.all(nil)).to(eq([new_task, new_task2]))
    end
  end
end
