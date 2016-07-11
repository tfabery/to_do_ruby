require('rspec')
require('pg')
require('list')

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe('List') do
  describe("#initialize") do
    it('should return the name of a newly created list') do
      new_list = List.new({name: "test_name", id: nil})
      expect(new_list.name()).to eq('test_name')
    end
  end

  describe('#save') do
    it('should return save new list to database') do
      new_list = List.new({name: 'test', id: nil})
      new_list.save()
      expect(List.all()).to eq([new_list])
    end

    describe("#find") do
      it "find list item" do
        new_list = List.new({name: 'test', id: nil})
        new_list.save()
        expect(List.find(new_list.id())).to eq(new_list)
      end
    end

  end



end
