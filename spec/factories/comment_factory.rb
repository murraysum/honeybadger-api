FactoryGirl.define do
  factory :comment, :class => Honeybadger::Read::Comment do
    id 1
    fault_id 2
    event "an event"
    source "app"
    notices_count 5
    author "John"
    body "This is a comment"
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end
end
