FactoryGirl.define do
  factory :notice, :class => Honeybadger::Api::Notice do
    id 1
    fault_id 2
    message "This is a runtime error"
    environment "production"
    request({:action => "runtime error"})
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end
end