FactoryGirl.define do
  factory :normal_team_member, :class => Honeybadger::Read::TeamMember do
    id 1
    name "John Smith"
    email "john.smith@example.com"
    admin false
    created_at Date.today

    initialize_with do
      new(id, name, email, admin, created_at)
    end
  end

  factory :admin_team_member, :parent => :normal_team_member do
    admin true
  end
end