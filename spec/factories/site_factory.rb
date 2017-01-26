FactoryGirl.define do
  factory :site, :class => Honeybadger::Api::Site do
    id "9eed6a7e-af77-4cc6-8c55-b7b17555330d"
    active true
    frequency 5
    last_checked_at "2016-06-15T12:57:29.646956Z"
    match nil
    match_type "success"
    name "Main site"
    state "down"
    url "http://www.example.com"

    initialize_with do
      new(attributes)
    end
  end
end
