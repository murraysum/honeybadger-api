FactoryGirl.define do
  factory :deploy, :class => Honeybadger::Read::Deploy do
    id 1
    project_id 2
    repository "honeybadger-read-api"
    revision "11111"
    association :environment, :strategy => :attributes_for
    local_username "deploy"
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end
end