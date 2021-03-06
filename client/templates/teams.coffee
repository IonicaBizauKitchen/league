Session.set 'adding_team', false

Template.teams.teams = -> Teams.find()

Template.team.games_path = -> games_path(this)
Template.team.players_path = -> players_path(this)
Template.team.alone_in_team = -> this.players().count() <= 1
Template.team.events = 
  'click .new_logo': ->
    this.prepare_logo(true)
    this.save()
  'click .remove_team': ->
    this.destroy()
  'click .team_status': ->
    show_team_status(this)

Template.team_builder.adding_team = -> Session.equals('adding_team', true)
Template.team_builder.events =
  'click .add_team.btn': -> 
    Session.set('adding_team', true)
    Meteor.flush()
    $('#team_name').focus()
    
