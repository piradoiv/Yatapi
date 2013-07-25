
currentStep = 0
$addTaskInput = $ '.yatapi-tasks .yatapi-addtask-input'
$addTaskInput.on 'keypress', (event) ->
  if currentStep is 1 and event.charCode is 13
    stepTwo()

stepOne = ->
  currentStep++

stepTwo = ->
  currentStep++
  $columns = $ '.tour .yatapi-column'
  $columns.fadeIn()

stepOne()
