FactoryGirl.define do
  factory :environment, :class => Honeybadger::Read::Environment do
    id 1
    name "production"
    project_id 2
    notifications true
    updated_at "2012-01-01T00:02:00Z"
    created_at "2012-01-01T00:01:00Z"
  end

  initialize_with do
    new(attributes)
  end
end