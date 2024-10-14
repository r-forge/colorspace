# Strategies and Software for Robust Color Palettes in Python

* Reto Stauffer (https://orcid.org/0000-0002-3798-5507)
* Achim Zeileis (https://orcid.org/0000-0003-0918-3766)

## Abstract

Color is a fundamental aspect in many data visualizations and suitable color choices are important for inclusivity, effectiveness, and clear communication of information. While many Python packages (e.g., including _matplotlib_ or _seaborn_) come with adequate color choices, they typically only provide a fixed set of color maps. Hence, we will discuss strategies and introduce software for designing and evaluating customized color maps that are suitable for a wide range of tasks and applications.

## Description

First, we will briefly motivate the importance of color along with possible pitfalls for a general audience interested in data visualization (5 min). Afterwards, we will discuss the principles for choosing good palettes along with strategies for selecting robust and inclusive color maps for different plot types (8 min). Subsequently, we will present our Python package _colorspace_ (12 min) which enables the creation or modification of robust custom color maps using the Hue-Chroma-Luminance (HCL) color model. Additionally, _colorspace_ offers methods for assessing and transforming colors from any source, e.g., by simulating color vision deficiencies, adjusting contrast ratios, lightening/darkening, etc. This makes it easy for both novices and experts to create and assess robust and effective color maps tailored to their needs, as well as incorporate them in their existing Python workflow.


## Additional information

* YT title (max 82 chars): Stauffer Reto and Zeileis Achim - Strategies and Software for Robust Color Palettes in Python
* Sponsoring: --no--
* Prior knowledge: No previous knowledge expected
* Affiliation: Universität Innsbruck
* Accessibility needs: --no--
* Profile picture: Das vom DiSC ausleihen
* Name: Reto Stauffer
* Biography: Associate Professor at the Department of Statistics and the Digital Science Center (DiSC) at Universität Innsbruck, Austria. His research is on the intersection of data science and atmospheric science, ranging from probabilistic modeling to data management, visualization, and applications.
* Availability: 4. Dec Weinachtsfeier DiSC


---

# [Proposal Guidelines](https://pydata.org/global2024/call-for-proposals)

The proposal selection process is double-blind, meaning that reviewers will not
be able to see your name or other identifying information. Reviewers will see
the proposal Title, Prior Knowledge Expected, Abstract, Bullet Point Outline,
and Description, and keywords. Please withhold identifying information from
those fields.

## Talks

Talks are 30-minute sessions including time for Q&A. A talk proposal is a short
description of a talk that is aiming to convince someone to part with 30
minutes of their time, in order to learn about something. A good proposal
should disclose:

* The topic (the WHAT) and WHY it is interesting
* The audience to WHOM the talk is addressed
* The TYPE of talk (lots of maths, hands-on, etc) and possibly the tone
  (light-hearted, informative, etc.)
* The TAKEAWAY, a.k.a. what will I learn

There are two parts to a proposal:

1. Abstract- This informs attendees what the talk is about. Discloses the
   topic, domain, and overall purpose. This is at most a few lines long and
   will be printed in the conference program.
2. Description - This is a self-contained statement that summarizes the aspects
   of the talk. It should be structured and present the objective of the talk,
   its outline, central thesis and key takeaways. After reading the
   description, the audience should have an idea of the overall presentation
   and know what to expect. The description should also make clear what
   background knowledge is expected from the attendees. Both this and the
   summary will be included in the talk details online.

While there is no strict template for this, you should make sure that the
audience can understand why your talk is relevant to them.


## Tips on How to Write a Successful Proposal

A proposal serves two purposes: 1) convince the Program Committee to accept
your proposal, and 2) act as the description of the talk/tutorial on the
schedule. If accepted, you will have the opportunity to further edit and
clarify the proposal ahead of the schedule’s publication.

The guidelines for proposing a talk versus a tutorial are essentially the same. 

**Good proposals include:**

* The topic and why it’s interesting
* The audience that will benefit from attending this talk/tutorial
* The takeaway for the audience
* Any background knowledge needed to understand the talk/tutorial
* Approximate time breakdowns of how the material will be covered, e.g. minutes
  0-10: X1, minutes 10-15: Y1, etc.

**There are two parts to a proposal:**

* _Abstract:_ The abstract tells attendees what the talk/tutorial is about. It
  should answer all of the above questions, but it should remain short and
  to-the-point. This is your chance to pitch attendees on watching your
  talk/tutorial. If you are submitting a tutorial proposal, the abstract should
  also specify the requirements for participating and how materials will be
  distributed (e.g. Github repo, links, etc). If your materials are already
  hosted publicly somewhere, you can include the link. 
* _Description:_ The description expands on the abstract and provides
  background and additional details about your talk/tutorial. It is often
  helpful for talk descriptions to include an outline of the talk/tutorial. The
  Program Committee reads each description carefully to determine if a
  talk/tutorial is a good fit. This is your chance to pitch the Program
  Committee on accepting your talk/tutorial. The Program Committee does
  occasionally ask for more information after proposals have been submitted,
  but it’s better to include relevant details up front and try to anticipate
  what questions the Committee will have after reading your proposal. For
  example, if you think the Committee may think you’re trying to cover too much
  ground, an outline with time estimates could help alleviate that concern.

## Additional Talk/Tutorial Proposal Suggestions

* **Who is your target audience?** Think about your target audience in terms of
  job role (data scientist, engineer, researcher, etc.) and experience level.
  Being clear about who you are speaking to (and the background knowledge you
  can expect them to have) is helpful both to you as you prepare your
  presentation, as well as to the audience considering whether your
  presentation is a good fit for them to attend.
* **Clear title:** A catchy title can be useful, but don’t overdo it. People
  should get a rough idea of what your presentation is about just by reading
  the title. Your proposal and your presentation should be consistent with your
  title.
* **Get feedback:** Ask friends and colleagues to review your abstract; bonus
  points if they are your target audience. Take time to tweak your abstract if
  needed. Additionally, if you are a first-time speaker, please indicate this
  in your proposal and we will reach out with more information regarding
  mentorship opportunities.

## Common Pitfalls

Here are some common pitfalls that could lead to the proposal not being
understood or rejected by the Program Committee:

* **Overly long proposals:** Keep it simple and clear. Good proposals typically
  provide all the important information within 200 words. This is not a strict
  limit, just a suggestion to help you stay focused.
* **Future work:** While talking about future work is interesting and could be
  mentioned in your talk, the core content of the talk should already be
  shaped, and you should be able to describe it in your proposal. Don’t rely
  too heavily on future data collection or future prototyping, because things
  often don’t go as expected.
* **Sales pitches:** We are a community of creators and users of open-source
  scientific computing tools. You can reference your closed-source product or
  platform, but the audience will find the talk more interesting if they can
  try your techniques with the open source PyData stack. Your problem
  definition, proposed techniques, and business domain are also interesting,
  but sales pitches are typically rejected.
* **Repeated talks:** We have a strong preference for new talks, and new
  speakers. If your talk is already available online, it is unlikely to be
  accepted for the conference. 


