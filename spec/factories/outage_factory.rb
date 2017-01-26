FactoryGirl.define do
  factory :outage, :class => Honeybadger::Api::Outage do
    down_at "2015-02-17T18:20:44.776959Z"
    up_at "2015-02-17T18:22:35.614678Z"
    created_at "2015-02-17T18:20:44.777914Z"
    status 301
    reason "Expected 2xx status code. Got 301"
    headers({
      :date => "Tue, 17 Feb 2015 18:20:44 GMT",
      :server => "DNSME HTTP Redirection",
      :location => "http://text.vote/polls",
      :connection => "close",
      :content_length => "0"
    })

    initialize_with do
      new(attributes)
    end
  end
end
