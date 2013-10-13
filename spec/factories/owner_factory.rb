FactoryGirl.define do
  factory :owner, :class => Honeybadger::Read::Owner do
    name "Tom Smith"
    email "tom.smith@example.com"

    initialize_with do
      new(name, email)
    end
  end
end