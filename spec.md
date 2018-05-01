# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship: Restaurant has_many :dishes, Dish has_many :list_items
- [x] Include at least one belongs_to relationship: Dish belongs_to :restaurant
- [x] Include at least one has_many through relationship: Dish has_many :lists, through: :list_items
- [x] The "through" part of the has_many through includes at least one user submittable attribute: list_item attribute "tasted"
- [x] Include reasonable validations for simple model objects: validations in both User and Dish models
- [x] Include a class level ActiveRecord scope method: Dish scope :most_popular, URL '/most_popular'
- [x] Include signup: own authentication logic and use of Rails has_secure_password
- [x] Include login: own authentication logic and use of Rails has_secure_password
- [x] Include logout: own authentication logic
- [x] Include third party signup/login: OmniAuth GitHub login
- [x] Include nested resource show or index: URL users/:user_id/dishes
- [x] Include nested resource "new" form: URL users/:user_id/dishes/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
