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
    admin true
    accepted_at Date.today
    created_at Date.today
    message "Come join in" 

    initialize_with do
      new(
        id,
        token,
        email,
        created_by,
        accepted_by,
        admin,
        created_at,
        accepted_at,
        message
      )
    end
  end
end