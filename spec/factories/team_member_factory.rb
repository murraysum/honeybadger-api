FactoryGirl.define do
  factory :normal_team_member, :class => Honeybadger::Read::TeamMember do
    id 1
    name "John Smith"
    email "john.smith@example.com"
    admin false
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end

  factory :admin_team_member, :parent => :normal_team_member do
    admin true
  end
end