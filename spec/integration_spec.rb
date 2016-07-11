require 'capybara/rspec'
require './app'
require 'launchy'
Capybara.app = Sinatra::Application
# set :show_exceptions, false

DB = PG.connect({:dbname => 'to_do_test'})

describe 'todo path', {:type => :feature} do
  it 'visits roots and creates a list' do
    visit('/')
    expect(page).to have_content('Add a List')
  end

  it "goto list_form page" do
    visit('/')
    click_link('add_list')
    expect(page).to have_content('Add')
  end

  it "add a new list" do
    visit('/')
    click_link('add_list')
    fill_in('name', :with => 'test')
    click_button('Add')
    expect(page).to have_content('test')
  end

  it "add a new list" do
    visit('/')
    click_link('add_list')
    fill_in('name', :with => 'test2')
    click_button('Add')
    expect(page).to have_content('test2')
    click_link('test2')
    expect(page).to have_content('test2')
  end

  it "add a new task" do
    visit('/')
    click_link('add_list')
    fill_in('name', :with => 'test2')
    click_button('Add')
    expect(page).to have_content('test2')
    click_link('test2')
    click_link('add_task')
    expect(page).to have_content('Add')
  end

  it "add a new task" do
    visit('/')
    click_link('add_list')
    fill_in('name', :with => 'test2')
    click_button('Add')
    expect(page).to have_content('test2')
    click_link('test2')
    click_link('add_task')
    fill_in('description', :with => 'BS')
    fill_in('due_date', :with  => '03/05/98')
    click_button('Add')
    expect(page).to have_content('BS')
  end
end
