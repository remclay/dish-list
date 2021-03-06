Dish-List Wish-List: functionality and features to add

- Reduce database queries using action caching (expiring on add or create);
- Improve custom validators for unique_dish and unique_restaurant to catch edge cases (eg. downcase strings before comparison, remove leading or trailing spaces or punctuation);
- Improve custom validators for unique_dish and unique_restaurant to raise error when select restaurant from dropdown and enter restaurant;
- Refactor implementation of custom validators to eliminate the need to skip validation on increase_popularity method in Dish class;
- Reduce duplication in css files - load application.css for each page and only amend as needed (vs duplicating all styling in each .css file);
- From a dishes/:dish_id page, allow users to view all other lists that include that dish;
- Eliminate need for page refresh when add or remove dish, or mark as tasted;
- Allow users to view dishes and/or restaurants via location, cuisine, by most recently added, alphabetically etc;
- Extend functionality to allow users to upload images of dishes, add comments and/or ratings once list_item is marked as tasted;
- Add OmniAuth login via Google, Facebook;
- Add further media queries for different sized screens.
