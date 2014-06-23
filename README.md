# Honeybadger Read API

A Ruby Library for the [Honeybadger Read API](https://www.honeybadger.io/documentation/read_api) for easily pulling your data out of [Honeybadger](https://www.honeybadger.io/).

## Installation

Add this line to your application's Gemfile:

    gem 'honeybadger-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install honeybadger-api

## Usage

### Introduction
Firstly require the library:

```
require 'honeybadger-api'
```

Then configure your personal API access token. Your personal API access token can be found on your [personal profile page](https://www.honeybadger.io/users/edit):

```
Honeybadger::Api.configure do |c|
  c.access_token = 'xxxxxxxxxxxxxxxxxxxx'
end
```

After you have setup your API access token you can now make requests.

### Projects

```
# Find a project
Honeybadger::Api::Project.find(project_id)

# Find all the projects
Honeybadger::Api::Project.all

# Retrieve a paginator for projects
paginator = Honeybadger::Api::Project.paginate
```

There are several methods that you should be aware of when using the paginator.

```
# Get a paginator for a resource
paginator = Honeybadger::Api::Project.paginate


# Retrieve a paginator for projects starting at a page
paginator = Honeybadger::Api::Project.paginate(:page => 5)

# Whether there are any more previous or next pages
paginator.previous?
=> true
paginator.next?
=> true

# Retrieve the previous or next pages
paginator.previous
paginator.next

# Retrieve the current page number
paginator.current_page

# Retrieve the total number of pages
paginator.total_page_count

# Return all previously requested pages as a Hash
paginator.pages
=> {
  1 => [
    #<Honeybadger::Api::Project @id=1, @name="Example">,
    #<Honeybadger::Api::Project @id=2, @name="Acme">
  ],
  2 => [
    #<Honeybadger::Api::Project @id=3, @name="Website">
  ]
}

# Return all previously requested pages as a collection
paginator.collection
=> [
  #<Honeybadger::Api::Project @id=1, @name="Example">,
  #<Honeybadger::Api::Project @id=2, @name="Acme">,
  #<Honeybadger::Api::Project @id=3, @name="Website">
]

```

### Deploys

```
# Find a deploy
Honeybadger::Api::Deploy.find(project_id, deploy_id)

# Find all the deploys
Honeybadger::Api::Deploy.all(project_id)

# Retrieve a paginator for deploys
Honeybadger::Api::Deploy.paginate(project_id)
```

### Faults
```
# Find a fault
Honeybadger::Api::Fault.find(project_id, fault_id)

# Find all the faults
Honeybadger::Api::Fault.all(project_id)

# Retrieve a paginator for faults
Honeybadger::Api::Fault.paginate(project_id)
```

### Notices
```
# Find a notice
Honeybadger::Api::Notice.find(project_id, fault_id, notice_id)

# Find all the notices
Honeybadger::Api::Notice.all(project_id, fault_id)

# Retrieve a paginator for notices
Honeybadger::Api::Notice.paginate(project_id, fault_id)
```
### Comments
```
# Find a comment
Honeybadger::Api::Comment.find(project_id, fault_id, comment_id)

# Find all the comments 
Honeybadger::Api::Comment.all(project_id, fault_id)

# Retrieve a paginator for comments 
Honeybadger::Api::Comment.paginate(project_id, fault_id)
```

### Teams
```
# Find a team
Honeybadger::Api::Team.find(team_id)

# Find all the teams
Honeybadger::Api::Team.all

# Retrieve a paginator for teams
Honeybadger::Api::Team.paginate

```
### Team Members
```
# Find a team member
Honeybadger::Api::TeamMember.find(team_id, team_member_id)

# Find all the team members
Honeybadger::Api::TeamMember.all(team_id)

# Retrieve a paginator for team members 
Honeybadger::Api::TeamMember.paginate(team_id)
```

### Team Invitations
```
# Find a team invitation 
Honeybadger::Api::TeamInvitation.find(team_id, team_invitation_id)

# Find all the team invitations 
Honeybadger::Api::TeamInvitation.all(team_id)

# Retrieve a paginator for team invitations 
Honeybadger::Api::TeamInvitation.paginate(team_id)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
