FactoryGirl.define do
  factory :integration, :class => Honeybadger::Read::Integration do
    name "Github"
    integration_id "rails/rails"

    initialize_with do
      new(name, integration_id)
    end
  end
end