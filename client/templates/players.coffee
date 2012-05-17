N_FRIENDS_TO_SHOW = 5
Session.set 'add_player_results', []

  
Template.add_player.results = -> Session.get 'add_player_results'

Template.add_player.events = 
  'keyup input[name*=name]': (event) ->
    self = this
    # @all_friends is set if we've had a response from FB
    if self.all_friends
      re = new RegExp $(event.target).val(), 'i'
      results = (f for f in self.all_friends when f.name.match(re))
      Session.set 'add_player_results', _.first(results, N_FRIENDS_TO_SHOW)
      
    else if not self.searching
      self.searching = true
      # we haven't even started searching et
      FB.api '/me/friends', (response) ->
        
        # store the data and try again
        self.all_friends = response.data
        $(event.target).keyup()