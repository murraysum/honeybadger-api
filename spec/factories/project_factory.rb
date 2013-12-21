FactoryGirl.define do
  factory :project, :class => Honeybadger::Read::Project do
    id 1
    name "Rails"
    association :owner, :factory => :user, :strategy => :attributes_for
    # users
    users [
      {
        :email => "user@example.com",
        :name => "user"
      }
    ]
    token "098sflj2"
    environments ["development", "production"]
    active true
    disable_public_links false
    # integrations
    fault_count 14
    unresolved_fault_count 1
    last_notice_at "2012-01-01T00:02:00Z"
    created_at "2012-01-01T00:01:00Z"

    initialize_with do
      new(attributes)
    end
  end

  factory :active_project, :parent => :project do
    active true
  end

  factory :inactive_project, :parent => :project do
    active false
  end

  factory :public_project, :parent => :project do
    disable_public_links false
  end

  factory :private_project, :parent => :project do
    disable_public_links true
  end
end