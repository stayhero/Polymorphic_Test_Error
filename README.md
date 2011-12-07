Today I faced a very weird error using polymorphic associations. In the rails console everything does almost often work, but the unit tests are failing all the time.

I setup a test Rails 3.1.3. app here (using SQLlite, but same error happens with mysql)
https://github.com/easychris/Polymorphic_Test_Error

To see the problem simply

```
cd polymorphic_test_error
bundle install
bundle exec rake db:setup
bundle exec rake db:fixtures:load
```
(but I guess you already know that ;-))

Basically, using the polymorphic association in the console like this works:

```ruby
Company.find(1).users.size == 2  # returns true
```

But the test case which does the same fails. I've found out that it fails in the console as well if you use these two calls (basically this is what the test does, in the same order, thus it fails):

```ruby
Company.find(1).designers.size == 1 # returns true
Company.find(1).users.size == 2  # now returns false, but should be true!
````

Same result if you run
```
bundle exec rake test:units
```



I've tried to simplify my existing database model as much as possible, so I can showcase the error with four models. Basically we have a Company, which has one or more departments. Each department has one or more users.

And now via polymorphic association each user can either have a  Designer or Developer entity.

schema.rb:

```ruby
ActiveRecord::Schema.define(:version => 20111207002230) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "title"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designers", :force => true do |t|
    t.string   "favorite_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developers", :force => true do |t|
    t.string   "favorite_software"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "typeable_id"
    t.string   "typeable_type"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
```

company.rb (model)

```ruby
class Company < ActiveRecord::Base
  has_many :departments
  has_many :users, through: :departments
  has_many :developers, source_type: 'Developer', source: :typeable  , through: :users
  has_many :designers, source_type: 'Designer', source: :typeable, through: :users
end
```

department.rb (model)

```ruby
class Department < ActiveRecord::Base
  has_many :users
  belongs_to :company
end
```

user.rb (model)

```ruby
class User < ActiveRecord::Base
  belongs_to :typeable, :polymorphic => true
end
````

designer.rb (model)

```ruby
class Designer < ActiveRecord::Base
  has_one :user, :as => :typeable
end
```

developer.rb (model)

```ruby
class Developer < ActiveRecord::Base
  has_one :user, :as => :typeable
end
````

BTW: I wanted to try with latest master, but after changing Gemfile to use rails edge, bundle install told me this:
*Could not find gem 'arel (~> 3.0.0.pre) ruby', which is required by gem 'rails (>= 0) ruby', in any of the sources.*


