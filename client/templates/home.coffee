Template.home.events =
  'submit .create_team': (event) -> 
    $(event).preventDefault();
    $form = $(this)
    AuthSystem.require_login ->
      console.log $form