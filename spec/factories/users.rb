FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    family_name           {person.last.kanji}
    first_name            {person.first.kanji}
    family_name_kana      {person.last.katakana}
    first_name_kana       {person.first.katakana}
    birthday              {Faker::Date.birthday(min_age: 5, max_age: 90)}
  end
end