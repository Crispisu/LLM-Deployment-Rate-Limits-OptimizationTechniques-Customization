#############################################
# Demo Script — Prompt Optimizer in OpenAI Playground
#############################################

# Demo Outline:
# 1. Creative Writing Prompt
# 2. Code Generation Prompt

--------------------------------------------------------------
# Prompt Optimizer

# What is the Prompt Optimizer?
# The Prompt Optimizer is a tool built into the OpenAI Playground (and the developer platform) that helps you refine, improve, and “harden” your prompt so that it elicits better, more consistent, more controllable results from the model (especially advanced models like GPT‑5). 

# Specifically, it:
# scans your prompt for common issues (contradictions, ambiguities, missing format specification). 
# OpenAI Cookbook
# rewrites or suggests improvements (embedding best-practices around structure, clarity, output specification). 
# gives you a version of the prompt optimized for performance with the target model/task. 

# It doesn’t guarantee “perfect prompt” in a one-click sense, but it accelerates prompt engineering and raises your baseline quality.

# Note that it can optimize your prompt automatically, OR you can suggest 1-line changes for you to make, and it will then modify the complex prompt
# You have the ability to Review the changes it makes - this will show a diff of the old and new prompts, as well as its reasoning for the change

--------------------------------------------------------------

# Go to https://platform.openai.com → Playground → Chat  

# Draft Prompt 1 (Creative Content)  
# Add a developer message

You are a creative assistant specialized in writing poetic texts about futuristic themes, especially space travel and cities of the future. Your task is to compose a poem that evokes the wonder of interstellar voyages, the silent hum of hyper-lanes, the spires of crystalline towers rising on distant planets, and the interplay of human dreams and alien horizons. Use rich imagery, metaphors, unexpected turns of phrase, and vivid descriptions of light, void and architecture. The poem should feel inspiring and imaginative, accessible yet profound, suitable for a general audience who enjoys science-fiction and speculative narratives. Take into account the scale of stars, the texture of terraformed landscapes, the rhythm of cosmic travel and urban life in orbit or on exoplanets. Aim for about twelve to sixteen lines (but you may vary length slightly if it serves the mood). Use no harsh language or profanity, keep tone uplifting though you may hint at challenge or mystery. You may optionally embed an unexpected twist or contrast—such as how technology mirrors nature, or how the cities sleep under alien skies—but avoid turning the poem into a story or long narrative summary. Try to maintain a consistent voice, avoid switching perspectives too wildly, and keep the language poetic and evocative rather than technical or dry.
 

# Click on "Optimize" on the top right

# Click on "Optimize" in the input text box

# You will get a response highlighted in blue

# Click on a few of the little comment icons to show the reasoning behind each chnage

# Click on "Review changes" at the bottom

# Click on "Save"

Futuristic Poem Generator

---------------------------------------

### NOTE: for each of the examples below, save our prompt as a draft, and create a new draft prompt

# NOTE: for every optimization, review changes as you go along
# Optimizations to perform:  
#   a. Add role & tone: 
You are a science‑fiction poet
#   b. Define structure: 
Specify stanzas/lines/metre.  
#   c. Define theme & emotion: 
Please include themes of discovery and leaving Earth.  
#   d. Define format instructions: 
Bold first line, italicize last line.  
# Paste draft → optimize → review changes.


### Draft Prompt 2 (Code Generation)  
# Draft: 
You are a software engineer, working on a Python project for a to‑do list app
# Optimizations:  
#   b. Define specs:
Allow add/list/delete tasks stored in JSON file.
#   c. Define output format: 
Return full script named ‘task_manager.py’, include comments.
#   d. Define edge‑cases/test instructions: 
Handle empty list, duplicate tasks.
# Paste draft → optimize → review.

# Click on "Save"

TODO App Python Generator






