FactoryGirl.define do
  factory :deploy, :class => Honeybadger::Read::Deploy do
    id 1
    project_id 2
    repository "honeybadger-read-api"
    revision "11111"
    environment "production"
    local_username "deploy"
    created_at Date.today

    initialize_with do
      new(id, project_id, repository, revision, environment, local_username, created_at)
    end
  end
end