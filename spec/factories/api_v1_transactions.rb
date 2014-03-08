# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_v1_transaction, :class => 'Api::V1::Transaction' do
    occured "2014-03-07 07:28:07"
    processor "MyText"
    amount "9.99"
    account nil
    reconciled false
  end
end
