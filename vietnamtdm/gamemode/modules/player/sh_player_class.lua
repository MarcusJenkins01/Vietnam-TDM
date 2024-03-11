local PLAYER_CLASS = {};

PLAYER_CLASS.WalkSpeed				= 160;		-- How fast to move when not running
PLAYER_CLASS.RunSpeed				= 240;		-- How fast to move when running
PLAYER_CLASS.CrouchedWalkSpeed		= 0.3;		-- Multiply move speed by this when crouching
PLAYER_CLASS.DuckSpeed				= 0.3;		-- How fast to go from not ducking, to ducking
PLAYER_CLASS.UnDuckSpeed			= 0.3;		-- How fast to go from ducking, to not ducking
PLAYER_CLASS.JumpPower				= 500;		-- How powerful our jump should be
PLAYER_CLASS.CanUseFlashlight		= true;		-- Can we use the flashlight
PLAYER_CLASS.MaxHealth				= 100;		-- Max health we can have
PLAYER_CLASS.MaxArmor				= 100;		-- Max armor we can have
PLAYER_CLASS.StartHealth			= 100;		-- How much health we start with
PLAYER_CLASS.StartArmor				= 0;		-- How much armour we start with
PLAYER_CLASS.DropWeaponOnDie		= false;	-- Do we drop our weapon when we die
PLAYER_CLASS.TeammateNoCollide		= true;		-- Do we collide with teammates or run straight through them
PLAYER_CLASS.AvoidPlayers			= true;		-- Automatically swerves around other players
PLAYER_CLASS.UseVMHands				= true;

function PLAYER_CLASS:Loadout()
    
end;

function PLAYER_CLASS:SetModel()
    
end;

-- function PLAYER_CLASS:ShouldDrawLocal()
    
-- end;

-- function PLAYER_CLASS:CreateMove(cmd)
    
-- end;

-- function PLAYER_CLASS:CalcView(view)
    
-- end;

-- function PLAYER_CLASS:GetHandsModel()
    
-- end;

-- function PLAYER_CLASS:StartMove(mv, cmd)
    
-- end;

-- function PLAYER_CLASS:FinishMove(mv)
    
-- end;

player_manager.RegisterClass( "player_tdm", PLAYER_CLASS, "player_sandbox" );
