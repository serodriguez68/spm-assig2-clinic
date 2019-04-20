Reset and seed database in production:

`heroku restart && heroku pg:reset DATABASE --confirm alenahealth && heroku run rake db:migrate && heroku run rails db:seed`
