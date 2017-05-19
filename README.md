<!--
Creator: Team editing by Cory
Market: SF
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Active Record

### Why is this important?
<!-- framing the "why" in big-picture/real world examples -->
*This workshop is important because:*

We're going to want to interact with the database and ActiveRecord is the machine that manages the Object Relational Mapping system for rails. That means it manages the schemas, models, and the shape of the (relational) database so that we can do all of the CRUD functionality we're used to! As described in the ActiveRecord Basics rails guide:  

> In Active Record, objects carry both persistent data and behavior which operates on that data.

In that way, it's a lot like the models we're used to from our work with Mongoose in the JS stack.

### What are the objectives?
<!-- specific/measurable goal for students to achieve -->
*After this workshop, developers will be able to:*

- Create a model that inherits from ActiveRecord class
- CRUD data in the database using our model
- Generate a migration to define a database schema
- use our model to interact with data in the Rails console

### Where should we be now?
<!-- call out the skills that are prerequisites -->
*Before this workshop, developers should already be able to:*

- describe and build models in a JavaScript application using Mongoose.
- Explain the model, view, controller pattern.

<img src="https://media.giphy.com/media/vjmSleUsnXU8o/giphy.gif" width="400" title="The files are in the computer!" alt="Zoolander Screenshot">

In this lab we will explore the "M" in our "MVC" (Model View Controller) Rails architecture by building an application for a fashion conference.

Lab Goals:
* Generate `Speaker` and `Talk` models
* Use ActiveRecord ORM methods to create and query records
* Write a seed file and run the `db:seed` task to populate the database with records
* Add validations and custom methods to models for richer behavior

## A Rails App with Speakers

1. **Create a new rails application**

  We're using the `rails new` command on the command-line to auto-magically create and configure our Rails application.

  Try typing `rails --help` in your Terminal, and you'll see this informative output:

  ```bash
      Usage:
        rails new APP_PATH [options]
  ```

  Let's try it out!


  ``` bash
  # rails new APP_PATH [options]
  rails new conference_app -T -d postgresql
  cd conference_app
  ```

  > We are using the `-T` (aka `--skip-test-unit`) and `-d postgresql` (aka `--database postgresql`) options today -- postgresl is our preferred database.
  
  Stop and commit!
  ``` bash
  git init
  git status
  git add . -A # add everything
  git commit -m "inital commit, rails application boilerplate"
  ```

  Take a moment to look around at your new app's file structure.

2. **Generate a `Speaker` model.**

  ``` bash
  rails generate model speaker first:string last:string email:string
  git status # show the files you just created!
  ```

  > `rails g` is shorthand for `rails generate`

  Examine the following new files:  
  * `app/models/speaker.rb`
  * `db/migrate/1234566789_create_speakers.rb`

  Stop and commit.

3. **Set up the database.**
  Next, create your application database:
  ```bash
  rake db:create # create a new database on your machine
  rake db:migrate # instruct your database to read and execute migration files
  git status # show the files you just created/edited!
  ```

  > You may see errors if postgresql isn't configured/linked correctly on your machine. Flag down an instructor for help. As a last resort, download and then launch Postgres.app. You will see an elephant in your menu if it's running.

  And take another look at your updated `db/schema.rb`!


  <details><summary>What is Rake?</summary>
    Rake is Ruby Make, a standalone Ruby utility that replaces the Unix utility `make`, and uses a `Rakefile` and `.rake` files to build up a list of tasks. In Rails, Rake is used for common administration tasks, especially sophisticated ones that build off of each other.

    You can get a list of Rake tasks available to you, which will often depend on your current directory, by typing

    ```bash
    $rake --tasks
    ```

    Each task has a description, and should help you find the thing you need.
  </details>

  Stop and commit!

4. **Launch the Rails console.**

  The Rails console is a Ruby REPL (like `pry` or `irb`) that comes with Rails and knows about your Rails app.

  ```bash
  rails console
  # or
  rails c
  ```

5. **Confirm that your model exists.**  
  ```ruby
  Speaker
   #=> Speaker(id: integer, first: string, last:string, email:string, created_at: datetime, updated_at: datetime)
  ```

  (You may need to "connect" to your database in the Rails console the first time you do this. Just follow the instructions Rails gives in the console. It will likely look like `call 'Speaker.connection' to establish a connection`)

  > Note that we never told our database to add fields for `id`, `created_at` and `updated_at`. These are added automatically, and we generally won't interact with them directly.



6. **Create your first Speaker record!**

  Unlike our previous DB experiences, with Rails, you can interact with the database easily using the Rails console! We can seed data entry-by-entry if we'd like! Let's do that and create a speaker:

  ``` ruby
  # reminder: create = new + save
  Speaker.create({first: "Leroy", last: "Brown", email: "lbrown@example.com"})
  Speaker.count
  Speaker.all
  ```

  > **Pro-Tip**: Remember, when you're working in the console/repl `up-arrow` is your friend!



## Record Creation and Query Challenges

Try typing `Speaker.` and then hitting tab twice. Notice that there are 636 methods that ActiveRecord provides for us to interact with this resource! That's quite a model! [Here's a description of some of them](http://guides.rubyonrails.org/active_record_querying.html). Below are some useful ones:

* ActiveRecord partial method list:

    * Class Methods: `all`,  `create`, `count`, `delete_all`, `destroy_all`, `find`, `first`, `last`, `order`, ...

    * Instance Methods:  `delete`, `destroy`,  `save`, `update`, `update_attributes`, ...

* [Active Record Basics Rails Guide](http://guides.rubyonrails.org/active_record_basics.html)

* [Active Record Query Interface Rails Guide](http://guides.rubyonrails.org/active_record_querying.html)

* http://api.rubyonrails.org/classes/ActiveRecord/Base.html

**Create and query Speaker records in the Rails console.**

Because we can interact with our data directly through the Rails console, we should practice some of the manipulation that we can do. Here are some challenges to get you working with data:


* Create 3 new speakers in the Rails Console.

* Create 4 speakers at once by passing the following array to the create method:
  ```ruby
  speakers_data = [
      {:first=>"Cory", :last=>"Fauver", :email=>"cory@example.com"},
      {:first=>"Brianna", :last=>"Veenstra", :email=>"brianna@example.com"},
      {:first=>"Matt", :last=>"Laguardia", :email=>"matt@example.com"},
      {:first=>"Ilias", :last=>"Tsangaris", :email=>"ilias@example.com"}
  ]
  ```

* Delete the last speaker you created.

* Find only the first speaker.

* Find only the last two speakers.

* Find a speaker by id (try id `1`).

* Find a speaker by first name.

* Sort by last name (alphabetically).

* Update the email of the last speaker you created.

* Delete all the speakers you created.


## Seeding Data

1. **Take a look at `db/seeds.rb`.**

  Add the following line:
  ```ruby
  p "Hello from seeds.rb"
  ```

  Now run the following from your command line (not the rails console!):
  ```bash
  rake db:seed
  # Hello from seeds.rb
  ```

  One interesting thing about your `seeds.rb` file is that Rails has set it up to _already_ know about all of the models and gems in your application environment. Just tell it what data to create!

2. **Seed your database with speakers.**

  Create an array of speaker data, with at least three speakers.  Use `Speaker.create` on the array to create all the speakers at once!

  Run `rake db:seed` again, and then check all your speakers from inside the Rails console.

3. **Delete old seed records when you seed.**

  Add a line in your seed file to do `Speaker.delete_all` before the new speakers are created.

  Stop and commit!

4. **Include the [FFaker](https://github.com/ffaker/ffaker) gem in your project.**

  Add the `ffaker` gem to your Gemfile, and then `bundle`.

5. **Update your seed file to use FFaker data.**

  Take a look at the FFaker documentation linked above. Use ``FFaker`` to generate names and email addresses for 10 speakers, and add them to your database. You'll need to use [FFaker::Name](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md#ffakername) to create first and last names and  [FFaker::Internet.email](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md#ffakerinternet) to create email addresses.

  > Check out ffaker's [REFERENCE.md](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md) for a comprehensive list of the kind of data available.

  Stop and commit!

## Validations

1. **Add a built-in validator to the `Speaker` model.**

  Rails has built-in validations we can use to validate data before it's saved into the database.

  Conference organizers want some way to get in touch with speakers.  Add a validation inside the `Speaker` model class to make sure each speaker has an email address:

  ```ruby
  # app/models/speaker.rb
  class Speaker < ActiveRecord::Base
    validates :email, presence: true
  end
  ```

2. **Test the validation in Rails console.**

  Back in your Rails console, try creating a speaker without an email address.  You should see `ROLLBACK` in the Rails console instead of `COMMIT`, meaning there was no change to your database.

  > Note: You may need to restart your Rails console. The Rails console runs the code that was present when you ran `rails c`, so if you update your code, you want to restart the console.

  Let's use the Rails console to see what happened:

  ```ruby
  > s = Speaker.create({})
     (0.2ms)  BEGIN
     (0.3ms)  ROLLBACK
    => #<Speaker id: nil, first: nil, last: nil, email: nil, created_at: nil, updated_at: nil>
  > s.valid?
    => false
  > s.errors.any?
    => true
  > s.errors.messages
    => {:email=>["can't be blank"]}
  ```

  Just as expected, our validation didn't pass, and we got an error message.

  See the Rails Guide on [Validations](http://guides.rubyonrails.org/active_record_validations.html) for more information on using validations, including how to create custom validations.

  Stop and commit!

## Model Methods

A Rails model is just a class. We can create instance methods to add behaviors we might want to use in other parts of the app.

1. **Add an instance method to the `Speaker` model.**

  Create a simple instance method using `FFaker` to have the speaker do a little speaking:

  ```ruby
  # app/models/speaker.rb
  class Speaker < ActiveRecord::Base
    validates :email, presence: true
    def speechify(blabber_duration=1)
      FFaker::HipsterIpsum.sentence(blabber_duration)
    end
  end
  ```

2. **Use the instance method.**

  In a real Rails app, an instance method might be used in the view.  However, it's a good idea to test it in the Rails console.

  ```ruby
  > Speaker.first.speechify
      Speaker Load (0.6ms)  SELECT  "speakers".* FROM "speakers"  ORDER BY "speakers"."id" ASC LIMIT 1
    => "American apparel fab trust fund fixie farm-to-table. Blog mixtape retro +1 organic."
  ```

  Stop and commit!

## Extra Practice & Stretch: `Talk` model


1. Generate a `Talk` model with attributes: `topic` (a string), `duration` (an integer), and `start_time` (a `datetime`).


2. Run `rake db:migrate` to update your schema with this new model, then head over to the Rails console and create a `Talk` instance as a sanity check.


3. Add a validator to your `Talks` model to require that the `start_time` be present.  Also require that the length of the `topic` string be between 3 and 100 characters.

4. Add code to your seed file to create `Talk`s.  Here's some sample data you could use, or create some with FFaker:

  ```ruby
  talks_data = [
      {:topic=>"A Fashion School for Ants?", :duration=>90, :start_time=>DateTime.now-(1.0/24)},
      {:topic=>"Button-down Bliss", :duration=>45, :start_time=>DateTime.now+(23.0/24)},
      {:topic=>"Ambi-turning", :duration=>30, :start_time=>DateTime.now+(2.0/24)},
      {:topic=>"The Joy of Jumpsuits", :duration=>30, :start_time=>DateTime.now+(4.0/24)}
  ]
  ```


5. Using `after_initialize` [ActiveRecord Callback](http://guides.rubyonrails.org/active_record_callbacks.html) add default values for a talk's `duration` (e.g., 30) and `topic` (e.g., "TBD").


  <details><summary>hint</summary>
  Create a `add_default_values` instance method to use with `after_initialize`, and be careful not to overwrite a `duration` or `topic` passed in for the instance.
  </details>


6. Try a few complex queries:

* Select all talks with `start_times` in the future.


* Count the number of talks with the default `topic` ("TBD")


* Iterate through all the talks with the default `topic` and `puts` the start time of each. Bonus: format the start time in a more human readable way.

## Future Development Ideas

1. Add routes, controllers, and views for `Speaker` and `Talk` (more on this full process soon!).

2. Create an association (relationship) between speakers and talks (we'll talk about how to do this soon!).
