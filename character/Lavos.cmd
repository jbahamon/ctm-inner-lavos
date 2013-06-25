; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional)
;   buffer.time = time (optional)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas. Each of these
;   buttons or directions is referred to as a "symbol".
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   greater-than (>) - means there must be no other keys pressed or released
;                      between the previous and the current symbol.
;          egs. command = a, >~a   ;press a and release it without having hit
;                                  ;or released any other keys in between
;   You can combine the symbols:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;
;   Note: Successive direction symbols are always expanded in a manner similar
;         to this example:
;           command = F, F
;         is expanded when MUGEN reads it, to become equivalent to:
;           command = F, >~F, >F
;
;   It is recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This makes the command easier
;   to do.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. The default
;   value for this is set in the [Defaults] section below. A typical
;   value is 15.
;
; - buffer.time (optional)
;   Time that the command will be buffered for. If the command is done
;   successfully, then it will be valid for this time. The simplest
;   case is to set this to 1. That means that the command is valid
;   only in the same tick it is performed. With a higher value, such
;   as 3 or 4, you can get a "looser" feel to the command. The result
;   is that combos can become easier to do because you can perform
;   the command early. Attacks just as you regain control (eg. from
;   getting up) also become easier to do. The side effect of this is
;   that the command is continuously asserted, so it will seem as if
;   you had performed the move rapidly in succession during the valid
;   time. To understand this, try setting buffer.time to 30 and hit
;   a fast attack, such as KFM's light punch.
;   The default value for this is set in the [Defaults] section below. 
;   This parameter does not affect hold-only commands (eg. /F). It
;   will be assumed to be 1 for those commands.
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10


;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1


;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

;-| Hold Button |----------------------------------------------------------
; Please define Anim 74140108 in your AIR file if AND ONLY IF you place these
; 7 Hold Button commands immediately after the 11 Single Button and Hold Dir
; commands at the very top of your CMD list, as demonstrated here.
; In this version of the AI code, these commands are only used by the XOR
; method, and thus are optional.  But there remains a possibility that a
; future version of the helper method might be helped by having these
; commands placed here, and Anim 74140108 would then be used to indicate
; that a partner character has a compatible CMD.

[Command]
name = "holda"
command = /a
time = 1

[Command]
name = "holdb"
command = /b
time = 1

[Command]
name = "holdc"
command = /c
time = 1

[Command]
name = "holdx"
command = /x
time = 1

[Command]
name = "holdy"
command = /y
time = 1

[Command]
name = "holdz"
command = /z
time = 1

[Command]
name = "holdstart"
command = /s
time = 1

;--- None of your own command definitions should be above this line. ---

;-| CPU |--------------------------------------------------------------
; Note that if you make any changes to the basic one-button or recovery
; commands, you'll need to make the same changes to their matching commands here
; and/or in the XOR VarSet controller.  That includes things like, for example:
;  * changing the recovery command to use a different combination of buttons.
;  * renaming the b button command as "d", or the start button command as "s".
;  * switching the button names around, e.g. so button y triggers "a" and button a triggers "y".
;  * having more than one way to trigger the same command name.
; If you understand how the XOR method works, the proper changes should be obvious.
; If you don't understand it, then simply disable the lines in the XOR VarSet
; controller that correspond to the commands you've altered.

[Command]
name = "a2"
command = a
time = 1

[Command]
name = "b2"
command = b
time = 1

[Command]
name = "c2"
command = c
time = 1

[Command]
name = "x2"
command = x
time = 1

[Command]
name = "y2"
command = y
time = 1

[Command]
name = "z2"
command = z
time = 1

[Command]
name = "start2"
command = s
time = 1

[Command]
name = "holdfwd2"
command = /$F
time = 1

[Command]
name = "holdback2"
command = /$B
time = 1

[Command]
name = "holdup2"
command = /$U
time = 1

[Command]
name = "holddown2"
command = /$D
time = 1

[Command]
name = "holda2"
command = /a
time = 1

[Command]
name = "holdb2"
command = /b
time = 1

[Command]
name = "holdc2"
command = /c
time = 1

[Command]
name = "holdx2"
command = /x
time = 1

[Command]
name = "holdy2"
command = /y
time = 1

[Command]
name = "holdz2"
command = /z
time = 1

[Command]
name = "holdstart2"
command = /s
time = 1

[Command]
name = "recovery2"
command = a+b
time = 1

; Here add matching commands for any moves that must never be used randomly
; by the computer, such as suicide moves and super moves, and add the pairs
; to the XOR VarSet controller in State -3.

; If you're desperate to make sure that the AI always gets turned on as soon
; as possible, you can add more equivalents for your own commands here too,
; and add to the XOR VarSet controller's triggers accordingly.

; And of course, if you've run out of unique command labels (Mugen allows
; 128), you can remove as many of these as you want.  You'll of course need
; to modify the XOR VarSet controller's triggers accordingly, but Mugen
; will let you know if you forget to do so. :)

;-| Motions |--------------------------------------------------------

[Command]
name = "Lasers"
command =  ~D, D, D, c
time=45

[Command]
name = "Evil Emanation"
command =  ~D, U, c
time=30

[Command]
name = "Shadow Slay"
command =  ~D, D, c
time=30

[Command]
name = "Protective Seal - Left"
command =  ~D, D, a
time=30

[Command]
name = "Protective Seal - Right"
command =  ~D, D, b
time=30

[Command]
name = "Obstacle"
command = ~U,U, c
time=30

[Command]
name = "Freeze - Left"
command = ~U,U, a
time=30

[Command]
name = "Freeze - Right"
command = ~U,U, b
time=30

[Command]
name = "Span Death - Left"
command = ~D,U, a
time=30

[Command]
name = "Span Death - Right"
command = ~D,U, b
time=30

;-| Double Tap |-----------------------------------------------------------
;[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10


[Command]
name = "recovery"
command = a+b
time = 1



;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]


;===========================================================================

;----------------------AI----------------------

; The main purpose of having these next two controllers here at the top of
; StateDef -1 is to make sure the AI helper never changes to a different state,
; but they also improve efficiency by preventing Mugen from wasting time
; processing the entire State -1 for the helper.
[State -1, AI Helper Check]
type = ChangeState
trigger1 = IsHelper(9741)
value = 9741

[State -1, AI Helper Check 2]
type = ChangeState
trigger1 = IsHelper(9742)
value = 9742

; This is generally the best place to put most of your AI directives.  For
; example, this controller would only be executed when the CPU is in control:
;
; [State -1, Haha!]
; type = ChangeState
; trigger1 = var(0) ; (Or use "var(58)>0" if you've chosen not to
;                   ; use the Simplifier variable/controller.)
; trigger1 = ctrl
; trigger1 = StateType = S
; trigger1 = MoveType = I
; trigger1 = P2MoveType = H
; trigger1 = NumEnemy = 1
; trigger1 = Enemy,GetHitVar(HitTime) > 60
; trigger1 = PrevStateNo != 195
; trigger1 = Random < 99
; value = 195

; And of course, most human-only command-based ChangeStates also belong
; in State -1.  For example, this move would only be performable by a human:
;
; [State -1, Death Before Dishonor]
; type = ChangeState
; trigger1 = command = "suicide"
; trigger1 = !var(0) ; (Or use "var(58)<1" if you've chosen not to
;                    ; use the Simplifier variable/controller.)
; trigger1 = ctrl
; trigger1 = StateType != A
; trigger1 = MoveType = I
; value = {suicide state number}


;----------------------Attacks----------------------

[State -1, Shadow Doom Blaze]
type = ChangeState
value = 280
triggerall = Var(1)&&Var(2)&&power>=3000&&ctrl&&Stateno!=280
trigger1 = command = "Lasers"&&!var(15)
trigger2=var(15)&&random<299

[State -1, Laser beams - Doors of Doom open.]
type = ChangeState
value = 220
triggerall = !Var(1)&&!Var(2)&&power>=2000&&ctrl
trigger1 = command = "Lasers"&&!var(15)
trigger2=var(15)&&random<399&&var(12)!=[1,60]

[State -1, Evil Emanation]
type = ChangeState
value = 290
triggerall = Var(1)&&Var(2)&&power>=100&&ctrl
trigger1 = command = "Evil Emanation"&&!var(15)
trigger2=var(15)&&fvar(5)=0.0&&random<200&&(enemynear,statetype=L)
trigger3=var(15)&&fvar(5)=0.05&&random<150&&(enemynear,statetype=L)
trigger4=var(15)&&fvar(5)=0.1&&random<100&&(enemynear,statetype=L)
trigger5=var(15)&&fvar(5)=0.15&&random<50&&(enemynear,statetype=L)

[State -1, Shadow Slay]
type = ChangeState
value = 270
triggerall = Var(1)&&Var(2)&&power>=1000&&ctrl
trigger1 = command = "Shadow Slay"&&!var(15)
trigger2=var(15)&&(p2dist x=[-70,70])&&var(14)>0&&random<10&&(random%4=0)
trigger3=var(15)&&(p2dist x=[-70,70])&&var(14)=0&&random<30&&(random%4>0)

[State -1, Obstacle]
type = ChangeState
value = 230
triggerall= power>=1000&&NumHelper(2030)=0&&ctrl
trigger1 = command = "Obstacle"&&!var(15)
trigger2=var(15)&&(p2dist x=[-70,70])&&(var(11)+var(12)+var(14))>0&&random<10&&(random%4>0)
trigger3=var(15)&&(p2dist x=[-70,70])&&(var(11)+var(12)+var(14))=0&&random<25&&(random%4>0)

[State -1, Freeze Left]
type = ChangeState
value = 304
triggerall = !Var(2)&&power>=1000&&ctrl&&NumHelper(2040)=0
trigger1= command="Freeze - Left"&&!var(15)
trigger2=var(15)&&(p2dist x!=[-60,60])&&((var(11))>0)&&random<(ifelse(!Var(1),5,10))&&(random%4>0)
trigger3=var(15)&&(p2dist x!=[-60,60])&&((var(12))>0)&&random<(ifelse(!Var(1),1,2))&&(random%4>0)
trigger4=var(15)&&(p2dist x!=[-60,60])&&((var(11)+var(12))=0)&&random<(ifelse(!Var(1),10,25))&&(random%4>0)


[State -1, Freeze Right]
type = ChangeState
value = 204
triggerall = !Var(1)&&power>=1000&&ctrl&&NumHelper(2040)=0
trigger1= command="Freeze - Right"&&!var(15)
trigger2=var(15)&&(p2dist x!=[-60,60])&&((var(11))>0)&&random<(ifelse(!Var(2),5,10))&&(random%4>0)
trigger3=var(15)&&(p2dist x!=[-60,60])&&((var(12))>0)&&random<(ifelse(!Var(2),1,2))&&(random%4>0)
trigger4=var(15)&&(p2dist x!=[-60,60])&&((var(11)+var(12))=0)&&random<(ifelse(!Var(2),10,25))&&(random%4>0)

[State -1, Span Death Left]
type = ChangeState
value = 305
triggerall = !Var(2)&&power>=1000&&ctrl
trigger1= command="Span Death - Left"&&!var(15)
trigger2=var(15)&&(life<1845)&&((var(11)+var(12))=0)&&random<(ifelse(!Var(1),2,4))
trigger3=var(15)&&(life<1845)&&((var(11)+var(12))!=0)&&random<(ifelse(!Var(1),15,25))

[State -1, Span Death Right]
type = ChangeState
value = 205
triggerall = !Var(1)&&power>=1000&&ctrl
trigger1= command="Span Death - Right"&&!var(15)
trigger2=var(15)&&(life<1845)&&((var(11)+var(12))=0)&&random<(ifelse(!Var(2),2,4))
trigger3=var(15)&&(life<1845)&&((var(11)+var(12))!=0)&&random<(ifelse(!Var(2),15,25))

[State -1, Protective Seal Left]
type = ChangeState
value = 302
triggerall = !Var(2)&&ctrl&&power>=100&&(NumHelper(2011)+NumHelper(2012)+NumHelper(2013)+NumHelper(2014)+NumHelper(2015)+NumHelper(2016)+NumHelper(2017)+NumHelper(2018)=0)
trigger1= command="Protective Seal - Left"&&!var(15)
trigger2=var(15)&&(p2dist x!=[-50,50])&&random<(ifelse(!Var(1),7,12))&&(random%2=0)

[State -1, Protective Seal Right]
type = ChangeState
value = 202
triggerall = !Var(1)&&ctrl&&power>=100&&(NumHelper(2011)+NumHelper(2012)+NumHelper(2013)+NumHelper(2014)+NumHelper(2015)+NumHelper(2016)+NumHelper(2017)+NumHelper(2018)=0)
trigger1= command="Protective Seal - Right"&&!var(15)
trigger2=var(15)&&(p2dist x!=[-50,50])&&random<(ifelse(!Var(2),7,12))&&(random%2=0)

[State -1, Flame Battle]
type = ChangeState
value = 260
triggerall = Var(1)&&Var(2)&&ctrl
trigger1 = command = "c"

[State -1, Hurricane Right]
type = ChangeState
value = 201
triggerall = !Var(1)&&NumHelper(2000)=0&&ctrl
trigger1= command="b"

[State -1, Hurricane Left]
type = ChangeState
value = 301
triggerall = !Var(2)&&NumHelper(2000)=0&&ctrl
trigger1= command="a"
