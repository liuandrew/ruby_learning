require 'rubygems'
require 'sqlite3'
$db = SQLite3::Database.new("test")
$db.results_as_hash = true

def disconnect_and_quit
    $db.close
    puts "Goodbye!"
    exit
end

def create_table
    puts "Creating people table"
    $db.execute %q{
      CREATE TABLE people (
      id integer primary key,
      name varchar(50),
      job varchar(50),
      gender varchar(6),
      age integer)
    }  
end

def add_person
    params = {name: "", job: "", gender: "", age: ""}
    params.each do |key, value|
        puts "Enter #{key}:"
        params[key] = gets.chomp
    end
    $db.execute("INSERT INTO people (name, job, gender, age) VALUES (?, ?, ?, ?)",
    params[:name], params[:job], params[:gender], params[:age].to_i)
end

def find_person
    puts "Enter name or ID of person to find: "
    id = gets.chomp
    
    person = $db.execute("SELECT * FROM people WHERE name =? OR id = ?", id, id.to_i).first
    
    unless person
        puts "No results found"
        return
    end
    
    puts %Q{Name: #{person['name']}
Job: #{person['job']}
Gender: #{person['gender']}
Age: #{person['age']}}
end

loop do
    puts %q{Please select an option:

  1. Create people table
  2. Add a person
  3. Look for a person
  4. Quit}
    
    case gets.chomp
        when '1' then create_table
        when '2' then add_person
        when '3' then find_person
        when '4' then disconnect_and_quit
    end
end