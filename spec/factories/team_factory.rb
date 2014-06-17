FactoryGirl.define do
  factory :team, :class => Honeybadger::Api::Team do
    id 1
    name "team"
    association :owner, :factory => :user, :strategy => :attributes_for

    members([])
    projects([])
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end

  end
end