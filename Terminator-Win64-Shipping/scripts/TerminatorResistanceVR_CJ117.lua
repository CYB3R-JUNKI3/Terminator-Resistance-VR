--####################################
--# Terminator Resistance VR - CJ117 #
--####################################


local api = uevr.api
local params = uevr.params
local callbacks = params.sdk.callbacks

local Fpmesh = nil
local MMenu = false
local Cis_Interacting = false
local Cplaying = false
local Cis_Incut = false
local Cpaused = false
local JustCentered = false
local Crouched = false
local InVent = false
local Mshow = false
local Frogger = false
local CamActive = false
local Weap_Open = false
local Other_Aim = false
local TalkWait = false
local TorchOn = false
local Utorch = false
local Dead = false
local IsTutActive = false
local HudOnce = false
local TutSOnce = false
local TutHOnce = false
local IntPOnce = false
local IntEOnce = false
local IntCOnce = false
local MelOnce = false
local BeingThrown = false
local LShoulderDown = false
local Pcrouched = false
local FireOnce = false
local DoNotDisableUH = false
local WeaponTutActive = false
local HKWait = false
local StopWT = false
local Lockmesh = nil
local Get_Weap = nil
local Cur_Weap = nil
local FireWeap = nil
local WCmesh = nil
local Is_Interacting = nil
local IntMGDetect = nil
local IntDetect = nil
local Current_Interaction = nil
local CIntComp = nil
local C_I_Active = nil
local Cut_Tran_Aim = false
local IntActive = nil
local SetMelee = nil
local WeapTut = nil
local CurTut = nil
local SetCrouch = nil
local CrouchActive = nil
local HKmesh = nil
local HKHealth = nil
local HKBar = nil
local Cur_Talk_Level = nil
local Cur_Talk = nil
local Cur_Talk_Time = nil
local InitHeight = nil
local LeadPipe = nil
local mDown = false
local mUp = false
local offset = {}
local GThrow = false
local adjusted_offset = {}
local base_pos = { 0, 0, 0 }
local mAttack = false
local mDownC = 0
local mUpC = 0
local base_dif = 0
local LockLoc = nil
local do_lock = false
local do_hack = false
local lock_active = false
local hack_active = false
local is_running = false
local uv_on = false
local CamControl = false
local weap_loc = nil
local alt_time = nil
local is_paused = false
local pause_time = nil
local is_false = 0
local enableHook = false
local is_pickup = false
local is_end = false
local is_loading_sc = false
local is_cs = false

local function find_required_object(name)
	local obj = uevr.api:find_uobject(name)
	if not obj then
		return nil
	end

	return obj
end

local game_engine_class = find_required_object("Class /Script/Engine.GameEngine")
local l_game_engine_class = find_required_object("Class /Script/Engine.GameEngine")
local gun_tut_c = find_required_object("Class /Script/Terminator.MenuWindowUserWidget")
local intro_story_c = find_required_object("Class /Script/Engine.Actor")
local melee_mesh_c = find_required_object("Class /Script/Terminator.Weapon")
local pipe_mesh_c = find_required_object("Class /Script/Terminator.PlayerMeleeWeapon")
local hk_tank_health_c = find_required_object("Class /Script/Terminator.HKTankHealthComponent")
local anim_det_c = find_required_object("Class /Script/LevelSequence.LevelSequencePlayer")
local tut_c = find_required_object("WidgetBlueprintGeneratedClass /Game/UI/Popups/WB_Tutorial.WB_Tutorial_C")
local tutshow_fn = tut_c:find_function("ShowWindow")
local tuthide_fn = tut_c:find_function("HideWindow")
local intro_c = find_required_object("WidgetBlueprintGeneratedClass /Game/UI/Popups/WB_MoviePlayer.WB_MoviePlayer_C")
local introplay_fn = intro_c:find_function("Construct")
local introend_fn = intro_c:find_function("End")
local introclose_fn = intro_c:find_function("Close")

local function ThrowGranade()
	--FPPMesh
	local fpppawn = api:get_local_pawn(0)
	if fpppawn ~= nil then
		Fpmesh = fpppawn.FPPMesh
	end
end

local function CompleteReset()
	MMenu = false
	Cis_Interacting = false
	Cplaying = false
	Cis_Incut = false
	Cpaused = false
	JustCentered = false
	Crouched = false
	InVent = false
	Mshow = false
	Frogger = false
	CamActive = false
	Weap_Open = false
	Other_Aim = false
	TalkWait = false
	TorchOn = false
	Utorch = false
	Dead = false
	IsTutActive = false
	HudOnce = false
	TutSOnce = false
	TutHOnce = false
	IntPOnce = false
	IntEOnce = false
	IntCOnce = false
	MelOnce = false
	BeingThrown = false
	LShoulderDown = false
	Pcrouched = false
	FireOnce = false
	DoNotDisableUH = false
	WeaponTutActive = false
	HKWait = false
	StopWT = false
	Lockmesh = nil
	Get_Weap = nil
	Cur_Weap = nil
	FireWeap = nil
	WCmesh = nil
	Is_Interacting = nil
	IntMGDetect = nil
	IntDetect = nil
	Current_Interaction = nil
	CIntComp = nil
	C_I_Active = nil
	Cut_Tran_Aim = false
	IntActive = nil
	SetMelee = nil
	WeapTut = nil
	CurTut = nil
	SetCrouch = nil
	CrouchActive = nil
	HKmesh = nil
	HKHealth = nil
	Cur_Talk_Level = nil
	Cur_Talk = nil
	Cur_Talk_Time = nil
	InitHeight = nil
	LeadPipe = nil
	GThrow = false
end

local function LockFix()
	--LockMesh
	local lockpawn = api:get_local_pawn(0)
	local lock_mesh = lockpawn.PawnInteractionComponent.InteractionWith.LockpickActor.SkeletalMeshLock

	if do_lock == false then
		do_lock = true
		local right_controller_index = params.vr.get_right_controller_index()
		local right_controller_position = UEVR_Vector3f.new()
		local right_controller_rotation = UEVR_Quaternionf.new()
		params.vr.get_pose(right_controller_index, right_controller_position, right_controller_rotation)
		local RControllerRot = right_controller_rotation.x
		print("Rotation: " .. tostring(right_controller_rotation.x))
		--local LockLoc = nil


		if RControllerRot >= 0.3 then
			lock_mesh.RelativeLocation.Z = (RControllerRot * 25)
			lock_mesh.RelativeRotation.Roll = (RControllerRot * 25)
			LockLoc = (RControllerRot * 25)
		elseif RControllerRot >= 0.1 then
			lock_mesh.RelativeLocation.Z = (RControllerRot * 100)
			lock_mesh.RelativeRotation.Roll = (RControllerRot * 100)
			LockLoc = (RControllerRot * 100)
		elseif RControllerRot <= -0.1 then
			lock_mesh.RelativeLocation.Z = -(RControllerRot * 100)
			lock_mesh.RelativeRotation.Roll = -(RControllerRot * 100)
			LockLoc = -(RControllerRot * 100)
		elseif RControllerRot <= -0.3 then
			lock_mesh.RelativeLocation.Z = -(RControllerRot * 75)
			lock_mesh.RelativeRotation.Roll = -(RControllerRot * 75)
			LockLoc = -(RControllerRot * 75)
		else
			lock_mesh.RelativeLocation.Z = 0
		end
	end
	lock_mesh.RelativeLocation.Z = LockLoc
	lock_mesh.RelativeRotation.Roll = LockLoc
	--Lockmesh.RelativeLocation.Z = LockLoc
	--Lockmesh.RelativeRotation.Roll = LockLoc
	lockpawn.Flashlight:call("SetVisibility", true)
end

local function HackingFix()
	--HackMesh
	local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SceneComponent")
	if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

	local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

	local arms_mesh = nil
	for i, mesh in ipairs(skeletal_meshes) do
		if mesh:get_fname():to_string() == "DefaultSceneRoot" and string.find(mesh:get_full_name(), "PersistentLevel.B_HackingMinigame_C_") then
			hack_mesh = mesh
			--print(tostring(hack_mesh:get_full_name()))
			--print(tostring(Hackmesh.RelativeLocation.Z))

			break
		end
	end
	--local hack_mesh = hackpawn.PawnInteractionComponent.InteractionWith.MinigameActor.SkeletalMeshComponentPermaTicked

	if do_hack == false then
		do_hack = true
		local right_controller_index = params.vr.get_right_controller_index()
		local right_controller_position = UEVR_Vector3f.new()
		local right_controller_rotation = UEVR_Quaternionf.new()
		params.vr.get_pose(right_controller_index, right_controller_position, right_controller_rotation)
		local RControllerRot = right_controller_rotation.x
		print("Rotation: " .. tostring(right_controller_rotation.x))
		--local LockLoc = nil


		if RControllerRot >= 0.3 then
			hack_mesh.RelativeLocation.Z = (RControllerRot * 25)
			hack_mesh.RelativeRotation.Pitch = (RControllerRot * 25)
			HackLoc = (RControllerRot * 25)
		elseif RControllerRot >= 0.1 then
			hack_mesh.RelativeLocation.Z = (RControllerRot * 100)
			hack_mesh.RelativeRotation.Pitch = (RControllerRot * 100)
			HackLoc = (RControllerRot * 100)
		elseif RControllerRot <= -0.1 then
			hack_mesh.RelativeLocation.Z = -(RControllerRot * 100)
			hack_mesh.RelativeRotation.Pitch = -(RControllerRot * 100)
			HackLoc = -(RControllerRot * 100)
		elseif RControllerRot <= -0.3 then
			hack_mesh.RelativeLocation.Z = -(RControllerRot * 75)
			hack_mesh.RelativeRotation.Pitch = -(RControllerRot * 75)
			HackLoc = -(RControllerRot * 75)
		else
			hack_mesh.RelativeLocation.Z = 0
		end
	end
	hack_mesh.RelativeLocation.Z = HackLoc
	hack_mesh.RelativeRotation.Pitch = HackLoc
end

local function reset_height()
	local base = UEVR_Vector3f.new()
	params.vr.get_standing_origin(base)
	local hmd_index = params.vr.get_hmd_index()
	local hmd_pos = UEVR_Vector3f.new()
	local hmd_rot = UEVR_Quaternionf.new()
	params.vr.get_pose(hmd_index, hmd_pos, hmd_rot)
	base.x = hmd_pos.x
	base.y = hmd_pos.y
	base.z = hmd_pos.z
	if hmd_pos.y >= 0.4 then
		InitHeight = 0.05
	else
		InitHeight = -0.25
	end
	params.vr.set_standing_origin(base)
	--print(InitHeight)
end

local function crouch_height()
	local base = UEVR_Vector3f.new()
	params.vr.get_standing_origin(base)
	local hmd_index = params.vr.get_hmd_index()
	local hmd_pos = UEVR_Vector3f.new()
	local hmd_rot = UEVR_Quaternionf.new()
	params.vr.get_pose(hmd_index, hmd_pos, hmd_rot)
	base.x = hmd_pos.x
	base.y = hmd_pos.y
	base.z = hmd_pos.z
	params.vr.set_standing_origin(base)
end

local function WeaponHide()
	--Weapon
	local wpawn = api:get_local_pawn(0)
	local ActiveWeap = wpawn.WeaponComponent:GetCurrentWeapon()
	if ActiveWeap ~= nil then
		Get_Weap = ActiveWeap:get_fname():to_string()
		Cur_Weap = ActiveWeap:get_full_name()
		FireWeap = ActiveWeap
	end
end

local function ResetPlayUI()
	params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
	params.vr.set_mod_value("VR_CameraForwardOffset", "0.00")
	params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
	params.vr.set_mod_value("VR_CameraRightOffset", "0.00")
end

local function WeapFix()
	local wpawn = api:get_local_pawn(0)
	local ActiveWeap = wpawn.WeaponComponent:GetCurrentWeapon()
	local WeapFPMesh = wpawn.FPPMesh
	WeapFPMesh:SetMaterial(0, Parent)
	WeapFPMesh:SetMaterial(1, Parent)
	WeapFPMesh:SetMaterial(2, Parent)
	if ActiveWeap ~= nil then
		ActiveWeap.WeaponMesh:SetMaterial(0, Parent)
		ActiveWeap.WeaponMesh:SetMaterial(1, Parent)
		ActiveWeap.WeaponMesh:SetMaterial(2, Parent)
		ActiveWeap.MuzzleFX.Delay = 10.00
		--wpawn.WeaponComponent.MuzzleAttachPoint = "Weapon_socket"
	end
end

local function Load_Check()
	local game_engine = UEVR_UObjectHook.get_first_object_by_class(l_game_engine_class)

	local viewport = game_engine.GameViewport
	if viewport == nil then
		print("Viewport is nil")
		return
	end

	world = viewport.World

	if world.AuthorityGameMode ~= nil then
		pause_time = world.GameState.ReplicatedWorldTimeSeconds

		if pause_time == alt_time then
			is_false = is_false + 1
			if is_false > 20 then
				is_paused = true
			end
		else
			is_false = 0
			is_paused = false
		end
	end
end

print("TerminatorResistanceVR - CJ117")
params.vr.set_aim_method(0)
params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
params.vr.set_mod_value("UI_Distance", "4.500")
params.vr.set_mod_value("UI_Size", "3.60")
params.vr.set_mod_value("UI_X_Offset", "0.00")
params.vr.set_mod_value("UI_Y_Offset", "0.00")
params.vr.set_mod_value("VR_CameraForwardOffset", "0.00")
params.vr.set_mod_value("VR_CameraRightOffset", "0.00")
params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
params.vr.set_mod_value("VR_EnableGUI", "true")

uevr.sdk.callbacks.on_pre_engine_tick(function(engine, delta)
	Load_Check()
	if (is_paused == true and Cis_Incut == true) or is_pickup == true then
		params.vr.set_mod_value("VR_EnableGUI", "true")
	elseif is_paused == false and Cis_Incut == true then
		params.vr.set_mod_value("VR_EnableGUI", "false")
	end

	local Pawn = api:get_local_pawn(0)
	local PawnFN = Pawn:get_full_name()
	local Pcont = api:get_player_controller(0)
	local Pause_Inv = Pcont:get_property("bShowMouseCursor")
	local IsPlaying = Pawn.bInputEnabled
	local IsCrouched = Pawn.bIsCrouched
	local DModeCam = Pawn.DetectiveModeComponent.bCanDoPictures
	local DetectiveMode = Pawn.DetectiveModeEnterTimeline.bIsActive
	local ExitDetectiveMode = Pawn.DetectiveModeLeaveTimeline.bIsActive
	local WeaponSelect = Pawn.FPPHudWidget.WB_WeaponCircle.bActive
	local YawActive = Pawn.bUseControllerRotationYaw
	local PIntComp = Pawn.PawnInteractionComponent.bIsActive
	local ActiveRet = Pawn.FPPHudWidget.CurrentReticle
	local IsDead = Pawn.Death.bEnabled
	local IsThrown = Pawn.ThrowMechanicReceiverComponent.ActualPushMethod
	local WRActive = Pawn.WalkSpeedRecover.bIsActive
	local GranadeActive = Pawn.GrenadeMesh.bIsActive
	local ActiveWeap = Pawn.WeaponComponent:GetCurrentWeapon()
	local lock_freeze = Pawn.bUseControllerRotationYaw
	local char_move_mode = Pawn.CharacterMovement.MovementMode
	local Loot_Pickup = Pawn.FPPHudWidget
	--print(ActiveWeap:get_full_name())

	if Loot_Pickup.LootWindow ~= nil then
		is_pickup = true
	else
		is_pickup = false
	end

	if Pawn.WeaponComponent ~= nil and ActiveWeap ~= nil then
		if not string.find(ActiveWeap:get_full_name(), "NoWeapon") then
			Cur_Weap = ActiveWeap.WeaponMesh
			--print(Cur_Weap:get_full_name())
		else
			Cur_Weap = nil
		end
	end

	if Cplaying == true and Cur_Weap ~= nil and ActiveWeap ~= nil then
		WeapFix()
		weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(Cur_Weap)
		if Cur_Weap ~= nil then
			--print(Cur_Weap:get_full_name())
			weap_loc:set_hand(1)
			weap_loc:set_permanent(true)
			weap_loc = UEVR_UObjectHook.remove_motion_controller_state(Cur_Weap)
			weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(Cur_Weap)
			if string.find(Cur_Weap:get_full_name(), "Pistol") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "SmgUzi") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "Minigun") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 0.000, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "Plasma") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "RifleCar") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "RocketLauncher") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "Shotgun") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(0.000, 0.000, 0.000))
			elseif string.find(Cur_Weap:get_full_name(), "Garand") then
				weap_loc:set_rotation_offset(Vector3f.new(1.571, 2.633, 0.997))
				weap_loc:set_location_offset(Vector3f.new(-3.00, 15.308, 0.000))
			end
		end
	end

	local game_engine = UEVR_UObjectHook.get_first_object_by_class(game_engine_class)

	local viewport = game_engine.GameViewport
	if viewport == nil then
		print("Viewport is nil")
		return
	end
	local world = viewport.World
	Lastlevel = tostring(world.GameState.CheckpointTag)
	is_loading_sc = world.OwningGameInstance.bIsInLoadingScreen
	is_cs = world.OwningGameInstance.bIsInCutscene

	if is_loading_sc == true or is_cs == false then
		params.vr.set_mod_value("VR_EnableGUI", "true")
	end

	if IsPlaying == false and Cis_Incut == true then
		if IsThrown == nil then
			IsThrownFN = "None"
			BeingThrown = false
		else
			IsThrownFN = IsThrown:get_full_name()
			if BeingThrown == false then
				BeingThrown = true
				print("Terminator Throw")
				UEVR_UObjectHook.set_disabled(false)
			end
		end
	end

	--Interaction
	if Pawn.PawnInteractionComponent ~= nil then
		local picomp = Pawn.PawnInteractionComponent
		Is_Interacting = picomp.bIsInteracting
		IntMGDetect = picomp.InteractionWith
		Current_Interaction = picomp.InteractionDetectionComponent
		CIntComp = picomp.CurrentInteractionCandidate
		C_I_Active = picomp.InteractionDetectionComponent.bIsActive
		if Current_Interaction == nil then
			CurrentInteraction = false
		else
			CurrentInteraction = C_I_Active
		end
		if IntMGDetect == nil then
			IntDetect = "Not_Ready"
		else
			IntDetect = IntMGDetect:get_full_name()
		end
		if CIntComp ~= nil then
			if string.find(CIntComp:get_full_name(), "PersistentLevel.B_ShelterEntering") then
				Cut_Tran_Aim = true
			end
		end
	end

	--IntroMovieTest
	if intro_story_c == nil then print("intro_story_c is nil") end

	local intro_story = intro_story_c:get_objects_matching(false)

	for i, mesh in ipairs(intro_story) do
		if string.find(mesh:get_fname():to_string(), "B_StoryInterlude") and string.find(mesh:get_full_name(), "PersistentLevel") then
			IntActive = mesh.ShouldShowInterlude

			break
		else
			IntActive = false
		end
	end

	--MeleeControl
	if melee_mesh_c == nil then print("melee_mesh_c is nil") end

	local melee_mesh = melee_mesh_c:get_objects_matching(false)

	for i, mesh in ipairs(melee_mesh) do
		if string.find(mesh:get_fname():to_string(), "WP_MeleeType01_C") and string.find(mesh:get_full_name(), "ALL.PersistentLevel.WP_MeleeType01_C") then
			SetMelee = mesh
			if FireOnce == false then
				FireOnce = true
			end

			break
		end
	end

	--PipeArms
	if ActiveWeap ~= nil then
		if string.find(ActiveWeap:get_full_name(), "WP_NoWeapon_C") then
			if pipe_mesh_c == nil then print("pipe_mesh_c is nil") end

			local pipe_meshes = pipe_mesh_c:get_objects_matching(false)

			for i, mesh in ipairs(pipe_meshes) do
				if string.find(mesh:get_full_name(), "WP_MeleeType01_C_") and string.find(mesh:get_full_name(), "ALL.PersistentLevel.WP_MeleeType01_C") then
					LeadPipe = mesh.bHidden

					break
				else

				end
			end
		end
	end

	--WeaponTutorial
	if string.find(Pawn:get_full_name(), "L09_Shelter_ALL") then
		if gun_tut_c == nil then print("gun_tut_c is nil") end

		local gun_tut = gun_tut_c:get_objects_matching(false)

		for i, mesh in ipairs(gun_tut) do
			if string.find(mesh:get_full_name(), "B_TerminatorGameInstance_C_0") and string.find(mesh:get_full_name(), "WB_Tutorial_C_") then
				WeapTut = mesh
				CurTut = tostring(mesh.TutorialName)
				if string.find(CurTut, "WeaponModifications") and StopWT == false then
					WeaponTutActive = true
				end

				break
			end
		end
	end

	--CrouchControl
	SetCrouch = Pawn.CharacterMovement
	CrouchActive = SetCrouch.bWantsToCrouch

	--HKTank
	if string.find(Lastlevel, "rrrr") then
		if hk_tank_health_c == nil then print("hk_tank_health_c is nil") end

		local hk_tank_health = hk_tank_health_c:get_objects_matching(false)

		for i, mesh in ipairs(hk_tank_health) do
			if mesh:get_fname():to_string() == "HealthComponent" and string.find(mesh:get_full_name(), ".PersistentLevel.BOSS_FIGHT_CH_HKTank") then
				HKmesh = mesh
				HKHealth = HKmesh.Health
				HKBar = HKmesh.bShowHealthBar

				break
			end
		end
	end

	--Dialogue
	local dial_comp = world.AuthorityGameMode.DialoguePlayer

	if dial_comp ~= nil then
		Cur_Talk_Level = dial_comp:get_full_name()
		Cur_Talk = dial_comp.CurrentTimeline.Name:to_string()
		Cur_Talk_Time = dial_comp.CurrentTime
		--print(Cur_Talk)
		if string.find(Cur_Talk, "Intro") then
			Other_Aim = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
				Cpaused = true
				Cplaying = false
				Cis_Interacting = false
				Cis_Incut = false
				MMenu = false
				WeaponTutActive = false
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
				Mshow = true
				Frogger = false
				UEVR_UObjectHook.set_disabled(false)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "Argh!") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "Shoot that thing") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "Jacobgetup") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "ll cover you!") then
			Other_Aim = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "PlayerAnswer") then
			Other_Aim = true
			TalkWait = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "None") and TalkWait == true then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "L13_Expecting") then
			Other_Aim = false
			TalkWait = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "L21_Welcome") then
			Other_Aim = false
			TalkWait = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "BaronsSpeech") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Lastlevel, "rrrr") and HKHealth == 0.0 and HKWait == false then
			Other_Aim = true
			HKWait = true
			--print(Cur_Talk)
			print(HKHealth)
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "HKDOWN") and Cur_Talk_Time >= 2.0 and Cpaused == false and MMenu == false and Frogger == false and HKWait == true then
			--HKWait = false
			Other_Aim = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "Jennifer1") then
			DoNotDisableUH = true
			UEVR_UObjectHook.set_disabled(false)
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "PlayerIsReady") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "AerialsTurning") then
			Other_Aim = false
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "NewSequence6") then
			if string.find(Cur_Talk_Level, "L17_DockRuins") then else
				Other_Aim = true
				local cur_aim = params.vr.get_aim_method()
				if cur_aim ~= 0 then
					UEVR_UObjectHook.set_disabled(true)
					params.vr.set_aim_method(0)
				end
				--print(Cur_Talk)
			end
		end
		if string.find(Lastlevel, "EndingStart") then
			is_end = true
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				UEVR_UObjectHook.set_disabled(false)
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Lastlevel, "LetUsBegin") then
			Other_Aim = true
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 then
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
				UEVR_UObjectHook.set_disabled(true)
				params.vr.set_aim_method(0)
			end
			--print(Cur_Talk)
		end
		if string.find(Cur_Talk, "NewSequence0") then
			if string.find(Cur_Talk_Level, "L06_MedicalDistrict") then else
				Other_Aim = false
				local cur_aim = params.vr.get_aim_method()
				if cur_aim ~= 2 then
					params.vr.set_aim_method(2)
				end
				--print(Cur_Talk)
			end
		end
		if YawActive == false and Cis_Interacting == false then
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				if PIntComp == true then
					if cur_aim ~= 0 then
						params.vr.set_aim_method(0)
					end
				else
					params.vr.set_aim_method(2)
					Other_Aim = false
				end
			end
		end
	end

	if IsDead == true and Dead == false then
		Dead = true
		print("Dead")
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
	end

	if GranadeActive == true and Cplaying == true or LeadPipe == false and Cplaying == true then
		if GThrow == false then
			GThrow = true
			print("Granade/Melee")
			ThrowGranade()
		end
		Fpmesh:call("SetRenderInMainPass", true)
	elseif GranadeActive == false and GThrow == true and Cplaying == true or LeadPipe == false and GThrow == true and Cplaying == true then
		GThrow = false
		Fpmesh:call("SetRenderInMainPass", false)
	end

	--WeaponSelect
	if WeaponSelect == true and Weap_Open == false then
		Weap_Open = true
		print("Weapon Select")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
	elseif WeaponSelect == false and Weap_Open == true then
		Weap_Open = false
		print("Weapons Closed")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
	end

	if Pause_Inv == true and Mshow == false then
		Mshow = true
		print("Need UI")
		--params.vr.set_mod_value("VR_EnableGUI", "true")
	end

	if Cis_Incut == true and PIntComp == true then
		local cur_aim = params.vr.get_aim_method()
		if cur_aim ~= 0 then
			params.vr.set_aim_method(0)
		end
	end

	if string.find(Pawn:get_full_name(), "MAP_StartingMap") and MMenu == false
	then
		MMenu = true
		Cplaying = false
		Cis_Incut = false
		Cis_Interacting = false
		Cpaused = false
		print("In Menu")
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
		Mshow = true
		Frogger = false
		HKWait = false
		is_end = false
		UEVR_UObjectHook.set_disabled(true)
		params.vr.set_aim_method(0)
		params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
	elseif IsPlaying == false or Is_Interacting == true then
		if string.find(Pawn:get_full_name(), "MAP_StartingMap") then

		else
			if IntMGDetect == nil then IntDetect = "Not_Ready" else IntDetect = IntMGDetect:get_full_name() end

			if string.find(IntDetect, "Hacking") or string.find(IntDetect, "Lockpick") and Is_Interacting == true then
				if Frogger == false then
					Frogger = true
					Cis_Interacting = true
					Cplaying = false
					Cis_Incut = false
					Pawn:set_property("bFindCameraComponentWhenViewTarget", true)

					local c_aim = params.vr.get_aim_method()
					if c_aim ~= 0 then
						print("Hacking/Lockpick")
						InVent = true
					end
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
					params.vr.set_aim_method(0)
					params.vr.set_mod_value("UI_Distance", "0.595")
					params.vr.set_mod_value("UI_Size", "0.595")

					if string.find(IntDetect, "Lockpick") then
						LockFix()
						Pawn.Flashlight:call("SetVisibility", true)
					end
					if string.find(IntDetect, "Hacking") then
						--HackingFix()
					end
				else
					if string.find(IntDetect, "Lockpick") then
						lock_active = true
						LockFix()
						Pawn.Flashlight:call("SetVisibility", true)
					end
					if string.find(IntDetect, "Hacking") then
						hack_active = true
						--HackingFix()
					end
				end
			else
				if IsPlaying == false and Cis_Incut == false and Frogger == false then
					Cplaying = false
					Cpaused = false
					MMenu = false
					Cplaying = false
					Cis_Incut = true
					Cis_Interacting = false
					print("In Cut")
					Pawn:set_property("bFindCameraComponentWhenViewTarget", true)
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")

					if DoNotDisableUH == true then
						DoNotDisableUH = false
						UEVR_UObjectHook.set_disabled(false)
					else
						UEVR_UObjectHook.set_disabled(true)
					end
					params.vr.set_aim_method(0)
					params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
					params.vr.set_mod_value("VR_EnableGUI", "false")
					Mshow = false
				end
				if Is_Interacting == true and Cis_Interacting == false and Frogger == false then
					Cis_Interacting = true
					Cplaying = false
					Cis_Incut = false
					Other_Aim = false
					local cur_aim = params.vr.get_aim_method()
					if cur_aim ~= 0 then
						params.vr.set_aim_method(0)
					end
					print("In Talk")
					params.vr.set_mod_value("VR_EnableGUI", "true")
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
					UEVR_UObjectHook.set_disabled(true)
					Mshow = true
				end
				local cur_aim = params.vr.get_aim_method()
				if cur_aim ~= 0 then
					params.vr.set_aim_method(0)
				end
				if WRActive == true then
					UEVR_UObjectHook.set_disabled(false)
				end
			end
		end
	elseif Cplaying == false and Pause_Inv == false and CamActive == false then
		if string.find(Pawn:get_full_name(), "MAP_StartingMap") then

		else
			if IsPlaying == true and CurrentInteraction == true and Frogger == false then
				Cplaying = true
				CurrentInteraction = false
				Cis_Incut = false
				Cis_Interacting = false
				print("In Interactive Cut")
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				UEVR_UObjectHook.set_disabled(true)
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
				Mshow = false
			else
				if Other_Aim == true or YawActive == false or WeaponTutActive == true then
					print("Waiting to Play")
					if lock_active == true or hack_active == true then
						Pawn:set_property("bUseControllerRotationYaw", true)
					end
					local cur_aim = params.vr.get_aim_method()
					if cur_aim ~= 0 then
						params.vr.set_aim_method(0)
					end
				else
					Other_Aim = false
					Cplaying = true
					Cis_Interacting = false
					Cis_Incut = false
					print("Playing")
					ResetPlayUI()
					MMenu = false
					Cpaused = false
					Frogger = false
					Dead = false
					IsTutActive = false
					BeingThrown = false
					InVent = false
					do_lock = false
					do_hack = false
					enableHook = false

					Pawn.Flashlight:call("SetVisibility", false)
					Pawn:set_property("bUseControllerRotationYaw", true)
					Pawn:set_property("bFindCameraComponentWhenViewTarget", false)
					params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
					params.vr.set_mod_value("VR_EnableGUI", "true")
					Mshow = true

					if TalkWait == false then
						UEVR_UObjectHook.set_disabled(false)
						if IntActive == true or IsIntroActive == true then
							params.vr.set_aim_method(0)
							print("Intro Movie")
						else
							params.vr.set_aim_method(2)
						end
					end
					params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
				end
			end

			if Cut_Tran_Aim == true then
				params.vr.set_aim_method(0)
				print("Entering Shelter")
				Cut_Tran_Aim = false
			end
		end
	elseif DetectiveMode == true and DModeCam == true and CamActive == false then
		CamActive = true
		Cpaused = false
		Cplaying = false
		Cis_Interacting = false
		Cis_Incut = false
		print("DMode Camera")
		MMenu = false
		Mshow = true
		Frogger = false
		--params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		enableHook = true
		Pawn:set_property("bFindCameraComponentWhenViewTarget", true)
	elseif ExitDetectiveMode == true and DModeCam == true and CamActive == true then
		CamActive = false
		Cpaused = false
		Cplaying = false
		Cis_Interacting = false
		Cis_Incut = false
		print("Close DMode Camera")
		MMenu = false
		Mshow = false
		Frogger = false
		params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
		enableHook = false
		Pawn:set_property("bFindCameraComponentWhenViewTarget", false)
	elseif Pause_Inv == true and Cpaused == false then
		Cpaused = true
		Cplaying = false
		Cis_Interacting = false
		Cis_Incut = false
		print("Paused/Inventory")
		MMenu = false
		WeaponTutActive = false
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
		params.vr.set_mod_value("VR_EnableGUI", "true")
		Mshow = true
		Frogger = false
		UEVR_UObjectHook.set_disabled(false)
		params.vr.set_aim_method(0)
	end

	if IsCrouched == true and Frogger == false then
		local CurRet = Pawn.FPPHudWidget.CurrentReticle
		if CurRet == nil and InVent == false and Frogger == false or string.find(Pawn:get_full_name(), "Shelter") and InVent == false and Frogger == false then
			if string.find(Pawn:get_full_name(), "ShelterWasted") then
				WeaponHide()
				FireWeap:call("SetRenderInMainPass", false)
				if CurRet == nil then
					InVent = true
					params.vr.set_mod_value("VR_CameraUpOffset", "-25.00")
				end
			else
				Crouched = true
				InVent = true
				if Pcrouched == false then
					params.vr.set_mod_value("VR_CameraUpOffset", "-25.00")
					print("Crouched No Weapon")
				end
			end
		elseif CurRet ~= nil and InVent == true and Frogger == false then
			Crouched = true
			InVent = false
			params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
			print("Crouched With Weapon")
		end
	elseif IsCrouched == false and Crouched == true then
		if string.find(Pawn:get_full_name(), "ShelterWasted") then
			WeaponHide()
			FireWeap:call("SetRenderInMainPass", true)
		end
		Crouched = false
		InVent = false
		params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
		print("Stood")
	end

	if char_move_mode == 0 then
		params.vr.set_aim_method(0)
	elseif Cplaying == true and is_paused == true then
		params.vr.set_aim_method(0)
	elseif Cplaying == true and Other_Aim == true then
		params.vr.set_aim_method(0)
	elseif Cplaying == true and Cis_Incut == false then
		params.vr.set_aim_method(2)
	end

	if is_end == true then
		params.vr.set_mod_value("VR_EnableGUI", "true")
	end

	--MeleeGesture
	if Cplaying == true and not string.find(PawnFN, "Shelter") then
		local right_controller_index = params.vr.get_right_controller_index()
		local right_controller_position = UEVR_Vector3f.new()
		local right_controller_rotation = UEVR_Quaternionf.new()
		params.vr.get_pose(right_controller_index, right_controller_position, right_controller_rotation)

		offset[1] = right_controller_position.y - base_pos[1]
		offset[2] = right_controller_position.z - base_pos[2]
		adjusted_offset[2] = offset[2] + base_dif
		if offset[1] <= -0.02 then
			mDown = true
		end
		if adjusted_offset[2] <= -0.012 then
			mUp = true
		end
		if mDown and mUp then
			mDownC = 0
			mUpC = 0
			mDown = false
			mUp = false
			mAttack = true
		end
		base_pos[1] = right_controller_position.y
		base_pos[2] = right_controller_position.z
		base_dif = 0
		if offset[2] < 0 then
			base_dif = offset[2]
		end
		if mUp then
			mUpC = mUpC + 1
		end
		if mDown then
			mDownC = mDownC + 1
		end
		if mDownC > 1 or mUpC > 1 then
			mDownC = 0
			mUpC = 0
			mDown = false
			mUp = false
		end

		if mAttack == true then
			SetMelee:call("StartShooting")
			print("Melee Triggered")
			mAttack = false
		end
	end

	--TutorialPopups
	if tutshow_fn ~= nil and TutSOnce == false then
		print("Found TutShow function")
		TutSOnce = true
		tutshow_fn:hook_ptr(nil, function(fn, obj, locals, result)
			if Frogger == false and Cpaused == false then
				IsTutActive = true
				--print("Tutorial")

				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
				params.vr.set_aim_method(0)
			end
		end)
	end

	if tuthide_fn ~= nil and TutHOnce == false then
		print("Found TutHide function")
		TutHOnce = true
		tuthide_fn:hook_ptr(nil, function(fn, obj, locals, result)
			IsTutActive = false
			print("TutClosed")
			if Frogger == false then
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			end
			if WeaponTutActive == true then
				StopWT = true
				WeaponTutActive = false
			end
			if Cpaused == false and Cis_Interacting == false and Cis_Incut == false then
				params.vr.set_aim_method(2)
				print("ResumePlaying")
			end
			if Frogger == true then
				local tpawn = api:get_local_pawn(0)
				tpawn:set_property("bUseControllerRotationYaw", false)
			end
			if CamActive == true then
				CamActive = false
			end
		end)
	end

	--IntroMovies
	if introplay_fn ~= nil and IntPOnce == false then
		print("Found IntroPlay function")
		IntPOnce = true
		introplay_fn:hook_ptr(nil, function(fn, obj, locals, result)
			IsIntroActive = true
			print("Intro Movie")
			params.vr.set_mod_value("VR_EnableGUI", "true")
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 0 and MMenu == false and Mshow == false then
				params.vr.set_aim_method(0)
			end
		end)
	end

	if introend_fn ~= nil and IntEOnce == false then
		print("Found IntroEnd function")
		IntEOnce = true
		introend_fn:hook_ptr(nil, function(fn, obj, locals, result)
			IsIntroActive = false
			print("Intro Ended")
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
			end
		end)
	end

	if introclose_fn ~= nil and IntCOnce == false then
		print("Found IntroClose function")
		IntCOnce = true
		introclose_fn:hook_ptr(nil, function(fn, obj, locals, result)
			IsIntroActive = false
			print("Intro Closed")
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			local cur_aim = params.vr.get_aim_method()
			if cur_aim ~= 2 then
				params.vr.set_aim_method(2)
				Cplaying = true
			end
		end)
	end

	if Cpaused == true then
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
	end

	if WRActive == true and Cplaying == true then
		local cur_aim = params.vr.get_aim_method()
		if cur_aim ~= 0 then
			print("MidCut")
			params.vr.set_aim_method(0)
			Mid = true
		end
	else
		local cur_aim = params.vr.get_aim_method()
		if cur_aim ~= 2 and Cpaused == false and MMenu == false and Mid == true then
			Mid = false
			print("Resume from MidCut")
			if PIntComp == true and Cplaying == false then
				if cur_aim ~= 0 then
					params.vr.set_aim_method(0)
				end
			else
				params.vr.set_aim_method(2)
			end
		end
	end


	if string.find(Pawn:get_full_name(), "MAP_StartingMap") then
		local cur_aim = params.vr.get_aim_method()
		if cur_aim ~= 0 then
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
		end
	end
	alt_time = world.GameState.ReplicatedWorldTimeSeconds
end)

uevr.params.sdk.callbacks.on_pre_calculate_stereo_view_offset(function(device, view_index, world_to_meters, position,
																	   rotation, is_double)
	local pawn = uevr.api:get_local_pawn(0)
	if pawn ~= nil and enableHook then
		pawn_pos = pawn.RootComponent:K2_GetComponentLocation()
		position.x = pawn_pos.x
		position.y = pawn_pos.y
		position.z = pawn_pos.z + 76.0
	end
end)

uevr.sdk.callbacks.on_xinput_get_state(function(retval, user_index, state)
	if (state ~= nil) then
		if Cpaused == true or Cis_Interacting == true or Cplaying == false or Cis_Incut == true or MMenu == true or IsTutActive == true then
			if state.Gamepad.bLeftTrigger ~= 0 and state.Gamepad.bRightTrigger ~= 0 then
				if JustCentered == false then
					JustCentered = true
					params.vr.recenter_view()
					if Crouched == false then
						reset_height()
					end
					JustCentered = false
				end
			end
		end

		if ActiveRet == nil or string.find(PawnFN, "Shelter") and Frogger == false and Cis_Incut == false and Mshow == false then
			if state.Gamepad.wButtons & 0x0100 ~= 0 and Cis_Interacting == false and Cis_Incut == false and Cpaused == false and Utorch == false then
				if Utorch == false then
					Utorch = true
					print("D-Pad Active")
					params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				end
			end
			if state.Gamepad.wButtons & 0x0100 == 0 and Utorch == true then
				print("Thumb-Stick Active")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
				Utorch = false
			end
		end

		if Cplaying == true then
			if state.Gamepad.sThumbRY >= 30000 then
				if is_running == false and CamActive == false then
					is_running = true
					state.Gamepad.wButtons = state.Gamepad.wButtons | XINPUT_GAMEPAD_LEFT_THUMB
					is_running = false
				end
			end
		else
			if state.Gamepad.sThumbRY >= 30000 and CamActive == true then
				CamControl = true
				--print("Cam D-Pad Active")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			else
				if CamActive == true then
					params.vr.set_mod_value("VR_DPadShiftingMethod", "4")
				end
			end
		end

		if Cplaying == true or CamActive == true then
			if state.Gamepad.sThumbRY <= -30000 then
				if uv_on == false and Utorch == false then
					uv_on = true
					state.Gamepad.wButtons = state.Gamepad.wButtons | XINPUT_GAMEPAD_RIGHT_THUMB
					--uv_on = false
				end
			end
		end

		if state.Gamepad.sThumbRY >= -30000 then
			if uv_on == true then
				uv_on = false
			end
		end
	end
end)
