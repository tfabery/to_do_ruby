class List
  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each do |list|
      lists.push(List.new({name: list['name'], id: list['id'].to_i}))
    end
    lists
  end

  define_singleton_method(:find) do |id|
    found_list = nil
    DB.exec("SELECT * FROM lists WHERE id = #{id};").each do |list|
      found_list = List.new({name: list['name'], id: list['id'].to_i})
    end
    found_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  define_method(:==) do |other_list|
    self.name() == other_list.name() && self.id() == other_list.id()
  end

end
