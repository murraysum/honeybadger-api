FactoryGirl.define do
  factory :notice, :class => Honeybadger::Api::Notice do
    id "5a24f938-a578-427d-a92b-d2f134d4af67"
    url "https://app.honeybadger.io/projects/1/faults/2/5a24f938-a578-427d-a92b-d2f134d4af67"
    fault_id 2
    message "This is a runtime error"
    environment({
      :project_root => "/data/www/apps/myapp/releases/20160701085636",
      :environment_name => "production",
      :hostname => "web1.myapp.com",
      :pid => 22587
    })
    environment_name "production"
    cookies({:cookie => "monster"})
    web_environment({
      :REMOTE_ADDR=>"127.0.0.1",
      :REQUEST_METHOD=>"POST"
    })
    backtrace([
      {
        :number => "21",
        :file => "[PROJECT_ROOT]/lib/multivariate/participation/cookie_participation.rb",
        :method => "[]"
      },
      {
        :number => "21",
        :file => "[PROJECT_ROOT]/lib/multivariate/participation/cookie_participation.rb",
        :method => "get_existing_data"
      }
    ])
    association :deploy, :factory => :deploy, :strategy => :attributes_for
    request({:action => "runtime error"})
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end
end