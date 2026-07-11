The complete list of changes over the original ROM in Super Hard Bomberman:

# New Gameplay Features & Changes
* New Boss Rush mode – play against all 6 bosses in succession with no continues.
    * Two-player mode is supported.
* Three new battle stages:
    * Illusion Zone – soft blocks disappear and reappear mid-battle.
    * Arena Zone – a level without soft blocks where bonuses randomly appear.
    * Smoking Zone – all players start in the center, black smoke obscures the stage.
* Random selection mode in Battle Mode.
* The level start invincibility period was reduced to 5 seconds.
* Updated the number of points granted by bonus items.
* Changed to point-milestones that grant extra lives:
    * The original milestones were 5,000, 10,000, 20,000, 40,000, 80,000, 160,000...
    * The new milestones are 10,000, 20,000, 40,000, 60,000, 80,000, 100,000...

# Level Changes
* Completely reworked level progression with a steeper difficulty curve. The Question Mark/Random bonus item is more common, but otherwise stronger bonus items are reserved to later levels.
* Poison bonuses are now available in more Story Mode stages.
* Level clouds/fog/smoke are now available in different colors and opacity levels, and are now available in more stages.
* Level clouds/fog/smoke can animate their opacity in certain levels.
* Level clouds/fog/smoke can now move in more different speeds.
* Trampolines are now available in Story Mode, in both World 1 and World 6.
* The Light Zone spotlights are now available in Story Mode, in both World 2 and World 4.
* Random bomb drops (like in Battle Mode's Bomb Zone) are now available in Story Mode; in World 2, 3 and 6.
* The disappearing soft blocks in certain levels in World 2 now remain invisible for a longer period of time.
* Growing flower soft blocks are now available in Story Mode in World 3.
* Bomb-picking tractors are now available in Story Mode in World 3.
* Conveyor Belts are now available in Story Mode, in World 3.
* The tilesets from Battle Mode's Tunnel Zone and Warp Zone are now available in Story Mode, in World 4.
* Tunnels are now available in Story Mode, in World 4.
* Moon wraps are now available in Story Mode, in World 4.
* World 5's Mecha Bombermen now use higher difficulty AI settings, have more initial items, and require more hitpoints to beat.
* Level 6-2 now has a ring-like layout.

# Enemy Behaviors

* New enemy behaviors:
    * Smart Wanderer. Behaves like a normal Wanderer (e.g. Propene), but will not walk into explosions.
    * Smarter Wanderer. Behaves like a Smart Wanderer, but will also not walk into bomb ranges.
    * Smart Follower. Follows a nearby player while trying to avoid explosions and bomb ranges.
* Starnuts now uses the Smart Wanderer behavior.
* Kierun is now invincible while transformed. Its transformation animations are now faster.
* Douken now uses the Smart Wanderer behavior.
* Metal U now uses the Smart Follower behavior. It is also faster.
* Anzenda now uses the Smarter Wanderer behavior.
* Chameleoman now uses the Random Wanderer behavior while not transformed (instead of turner). While transformed, it retains its Follower behavior, but moves faster.
* Dengurin now uses the Turner behavior.
* Kouraru now uses the Follower behavior.
* Robocom now uses the Smart Follower behavior.
* Enemy scores have been adjusted to better reflect their difficulty.

# Boss Behaviors
Boss enemies were altered to be more challenging, and making previous strategies obsolete.

## Bigaron
* Bigaron now has 12 hitpoints instead of 10.
* The more damaged Bigaron is, the faster it moves.
* Bigaron remains invincible for a little longer after being hit, and will be able to move faster during the extra invincibility time.
* Bigaron's hammer pounds will stun the players, even if they were not hit.

## Clown Mask
* Clown Mask now moves and accelerates a lot faster.
* Clown Mask remains invincible during its charging attack.
* Clown Mask can now shoot its flares in two different sets of directions.
* Random bonuses will now appear during Clown Mask's boss battle.

## Crane Hand
* Crane Hand now has 15 hitpoints instead of 13.
* Crane Hand's missiles now use the Follower behavior. They also move faster.
* Crane Hand's missile may randomly drop bonuses after being hit.
* Crane Hand's movement speed now randomly changes.
* Crane Hand will now open its claws for a shorter amount of time before launching them forward.

## Mecha Onita
* Mecha Onita now has 20 hitpoints instead of 17.
* Bonuses appear more frequently in Mecha Onita's stage.
* Poison bonuses are now very common in Mecha Onita's stage.
* Mecha Onita will randomly bounce instead of stopping when it reaches the edge of the stage.
* The top row of the stage is no longer immune to being hit by Mecha Onita.
* The appearance of Mecha Onita's ghost trails were slightly adjusted to compensate for the now-required poison palette.
* A restored and remastered sound effect that was supposed to be played when Mecha Onita was hit was added back.

## Spiderer
* Spiderer now has 11 hitpoints instead of 7.
* Spiderer now launches bombs in a less predictable manner, making them harder to avoid.
* Hitting Spiderer no longer makes it stop.
* Spiderer will start launching bombs while moving after enough hits.

## Uiteru V
* Uiteru V now has 8 hitpoints instead of 5.
* The odds of certain bonus items during the boss fight were changed.
* Uiteru V will start a poison-throwing spree after being hit, and will remain invincible until the spree is over.

# New Enemies
* Bigaron is now available as a normal level enemy after its initial boss appearance.
* Missiles are now available as normal level enemies after their initial boss appearance.
* New enemy – Gold Kuwagen. A variant of Kuwagen with 3 hitpoints and faster charge time.

# Bugfixes and Other Improvements
* The original English version had an overflow in Bank 5 of the game, causing certain sound effects to corrupt. This was fixed in this ROM hack.
* Improvements to the random number generators used in the game.
* The Japanese draw screen is now used in the English version as well.
* The palettes for Kuro Bomberman's victory pose (in the English version) and the Normal Zone bombs were fixed.
* Fixes from the English version were backported to the Japanese version.
* The Japanese introduction scene is now available in the English version.
* All battle stages are now available in demo mode.
* Levels now use new passwords.
* Fixed Shiro's HUD icons so they're consistent with the rest of the Bombermen icons.
* Fixed a bug where Player 2's combo counters were not reset when starting the next level.
