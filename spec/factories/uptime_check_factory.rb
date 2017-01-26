FactoryGirl.define do
  factory :uptime_check, :class => Honeybadger::Api::UptimeCheck do
    up true
    location "Singapore"
    duration 1201
    created_at "2016-06-16T20:19:32.852569Z"

    initialize_with do
      new(attributes)
    end
  end
end
