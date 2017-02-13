FactoryGirl.define do
  factory :notification do
    user nil
    subscribed_user nil
    post nil
    identifier ""
    type ""
    read false
  end
end
