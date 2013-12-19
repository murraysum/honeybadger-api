FactoryGirl.define do
  factory :team_invitation, :class => Honeybadger::Read::TeamInvitation do
    id 1
    token "e62394d2"
    email "invitation@example.com"
    created_by({
      :email => "invitation.created@example.com",
      :name => "John Created"
    })
    accepted_by({
      :email => "invitation.accepted@example.com",
      :name => "John Accepted"
    })
    admin false
    accepted_at Date.today
    created_at Date.today
    message "Come join in"

    initialize_with do
      new(attributes)
    end
  end

  factory :admin_team_invitation, :parent => :team_invitation do
    admin true
  end
end