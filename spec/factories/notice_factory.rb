FactoryGirl.define do
  factory :notice, :class => Honeybadger::Api::Notice do
    id "5a24f938-a578-427d-a92b-d2f134d4af67"
    fault_id 2
    message "This is a runtime error"
    environment "production"
    environment_name "production"
    cookies({:cookie => "monster"})
    request({:action => "runtime error"})
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end
end