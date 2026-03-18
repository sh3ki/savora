# Savora

> A recipe discovery and meal planning app that brings every week's meals together in one place.

---

## Overview

Savora is a Flutter recipe app where users discover, save, and plan meals. Users browse a curated recipe feed, save recipes to named collections, build weekly meal plans by dragging recipes onto calendar days, and auto-generate a consolidated shopping list from the planned meals.

---

## Problem

People who cook at home face a fragmented workflow: recipes saved across browser bookmarks, social media saves, and paper notes; meal planning done mentally or in a notes app; and shopping lists rebuilt from scratch every week. There's no single tool for the full cycle.

---

## Solution

Savora closes the loop from recipe discovery to shopping cart. Find a recipe, save it, slot it into the week's plan, get your list. The app handles the kitchen logistics so users can focus on cooking.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Auth | Appwrite Auth (email + Google OAuth) |
| Database | Appwrite Database |
| Storage | Appwrite Storage (recipe cover images) |
| Backend | Appwrite Functions (Node.js) |
| State | flutter_bloc |
| Navigation | GoRouter |
| Animations | flutter_animate |
| Notifications | flutter_local_notifications |
| Offline | Hive |

---

## Features

**Core**
- Recipe feed: browse recipes by cuisine, meal type, cook time, and dietary label
- Recipe detail: ingredients list, step-by-step instructions, serving adjuster, nutrition summary
- Save recipes to named collections (Quick Meals, Date Night, Meal Prep)
- Weekly meal plan calendar: assign a recipe to any meal slot (breakfast, lunch, dinner) of any day
- Auto-generate shopping list from all ingredients across the week's planned meals — deduped and summed by unit
- Manual shopping list additions and cross-off-on-shop flow

**Backend & Infrastructure**
- Appwrite Auth with email/password and Google OAuth; sessions persisted in Appwrite's secure client store
- Appwrite Database collections: `recipes`, `collections`, `saved_recipes`, `meal_plans`, `shopping_lists` — document permissions scoped to owner user ID
- Appwrite Storage for cover images: recipes have cover images uploaded by content team; user-submitted recipe feature uses user-scoped buckets with 5 MB upload limit enforced on Storage rules
- Appwrite Function `generate-shopping-list`: triggered via HTTP call from client when user taps "Build My List" — reads all meal plan entries for the week, aggregates ingredient quantities across recipes, writes merged list to `shopping_lists` collection
- Appwrite Function `weekly-plan-notifications`: scheduled cron every Sunday evening — checks users with incomplete meal plans for the coming week, sends push payload to the notification service
- User-submitted recipes go through an Appwrite Function moderation step before being set to `status: published`
- Hive local cache for previously loaded recipes — app navigates and displays fully offline

**Discovery & UX**
- Infinite scroll feed with category and filter bar
- Full-text recipe search (title, ingredient, tag)
- Recipe rating and review — ratings stored in Appwrite with per-user uniqueness enforced by document permissions
- Ingredient substitution suggestions surfaced on the recipe detail page
- Shopping list item category grouping (Produce, Dairy, Meat, Pantry)
- Local notification reminder on Sunday at 7 PM if no meals are planned for the coming week

---

## Challenges

- Ingredient quantity aggregation across different recipes using inconsistent unit systems (cups vs ml vs grams)
- Implementing the meal plan calendar UI in Flutter with drag-and-drop recipe card assignment
- Keeping the offline Hive cache fresh when Appwrite recipe data is updated by the content team

---

## Screenshots

_Recipe Feed · Meal Plan · Shopping List · Collections_
