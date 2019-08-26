actions = %w(
  opened edited deleted transferred pinned unpinned closed reopened
  assigned unassigned labeled unlabeled locked unlocked milestoned demilestoned
)

5.times  do
  issue = Issue.create()
  10.times do
    Event.create!({
      issue: issue,
      action: actions[rand(actions.size)]
    })
  end
end
