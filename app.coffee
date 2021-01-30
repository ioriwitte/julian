# Prototying with Framer
# by Kenny Chen
# Random Hearts

Framer.Defaults.Animation.time = 0.3

new BackgroundLayer
	backgroundColor: "black"
	
# Put file names of hearts in array	
hearts = [
	"blue" 
	"orange" 
	"purple"
	"red" 
	"teal" 
	"yellow"
]

# Video courtesy of the Earth Science and Remote Sensing Unit, NASA Johnson Space Center
# http://eol.jsc.nasa.gov/
videoLayer = new VideoLayer 
	x:0
	y:230
	width:1624
	height:1080 
	video:"images/ffc-space.mp4"
videoLayer.player.loop = true
videoLayer.player.play()

# Make entire screen a button
hitTarget = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "transparent"
	
# Container for play/pause button
playPauseBtn = new Layer
	x: 642
	y: 1200
	backgroundColor: "transparent"	
	
inputLabel = new Layer
	x: 20
	y: 1212
	height: 80
	width: 610
	borderRadius: "10px"
	backgroundColor: "rgba(255, 255, 255, 0.24)"
inputLabel.html = "Say something..."
inputLabel.style = 
	"color": "#999999"
	"font-size": "30px"
	"padding-top": "24px"
	"padding-left": "24px"
		
# Set variables
lineWidth = 10
lineHeight = 50

firstLine = new Layer
	width: lineWidth
	height: lineHeight
	x:35
	backgroundColor:'#ffffff'
	borderRadius:'3px'
secondLine = new Layer
	width: lineWidth
	height: lineHeight
	x:55 
	backgroundColor:'#ffffff'
	borderRadius:'3px'
thirdLine = new Layer
	width: lineWidth
	height: lineHeight
	x:75
	backgroundColor:'#ffffff'
	borderRadius:'3px'
	opacity: 0
	rotation: 60
	
playPauseBtn.addSubLayer(firstLine)
playPauseBtn.addSubLayer(secondLine)
playPauseBtn.addSubLayer(thirdLine)

firstLine.centerY()
secondLine.centerY()	
thirdLine.centerY()	

playPauseBtn.on Events.Click, ->
	if videoLayer.player.paused
		videoLayer.player.play()
		firstLine.animate
			properties:
				x: 35
				y: 25
				rotation: 0
		secondLine.animate
			properties:
				x: 55
				y: 25
				rotation: 0
		thirdLine.animate
			properties:
				x: 75
				y: 25
				opacity: 0
				rotation: 60
	else
		firstLine.animate
			properties:
				x: 52
				y: 14
				rotation: 120
		secondLine.animate
			properties:
				x: 52
				y: 34
				rotation: 240
		thirdLine.animate
			properties:
				x: 32
				y: 24
				opacity: 1
				rotation: 0
		videoLayer.player.pause()	

# On a click, go to the next state
hitTarget.on Events.Click,(event)->
	h = createRandomHeart(event.offsetX, event.offsetY)
	a = createHeartAnimation(h)
	a.start()

# Clean up above code by putting it in a function
createRandomHeart = (xPosition, yPosition) ->
	random = Utils.randomChoice(hearts)
	heart = new Layer 
		x: xPosition, y: yPosition, width: 81, height: 72, image: "images/#{random}.png"
	return heart
	
createHeartAnimation = (heartLayer) ->
	moveY = Utils.randomNumber(300, 400)
	startY = heartLayer.y
	heartStart = new Animation
		layer: heartLayer
		properties:
			x: heartLayer.x + Utils.randomNumber(-50, 50)
			y: startY - moveY
			opacity: 0.5
			rotation: Utils.randomNumber(-30, 30)
		time: 2
		delay: 0.1	
		curve: "linear"
	heartStart.on Events.AnimationEnd, ->
		heartLayer.animate	
			properties:
				x: heartLayer.x + Utils.randomNumber(-50, 50)
				y: startY - moveY * 2
				opacity: 0
				rotation: Utils.randomNumber(-30, 30)
			time: 2	
			curve: "linear"
	return heartStart
