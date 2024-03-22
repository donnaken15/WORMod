StarPower_Out_SFX_struct = $#"0xfb849dbe"
StarPower_Out_SFX_container = {
	Command = PlaySound
	Randomness = None
	Sounds = {
		Sound1 = {
			sp_lose
			vol = 80
		}
	}
}
Star_SFX_struct = $#"0xfb849dbe"
Star_SFX_container = {
	Command = PlaySound
	Randomness = None
	Sounds = {
		Sound1 = {
			star
			vol = 110
		}
	}
}

script GuitarEvent_StarPowerOn
	GH_Star_Power_Verb_On
	FormatText checksumName = scriptID '%p_StarPower_StageFX' p = <player_text>
	SpawnScriptLater Do_StarPower_StageFX id = <scriptID> params = {<...> }
	StarPowerOn Player = <Player>
	Create_Highway_Star_Power_Effect Player = <player>
endscript
script GuitarEvent_StarPowerOff
	SoundEvent \{event = #"0x2af89aeb"}
	GH_Star_Power_Verb_Off
	spawnscriptnow rock_meter_star_power_off params = {player_text = <player_text>}
	SpawnScriptLater Kill_StarPower_StageFX params = {<...> }
	ExtendCrc starpower_container_left <player_text> out = cont
	if ScreenElementExists id = <cont>
		DoScreenElementMorph id = <cont> time = 0.5 alpha = 0
	endif
	ExtendCrc starpower_container_right <player_text> out = cont
	if ScreenElementExists id = <cont>
		DoScreenElementMorph id = <cont> time = 0.5 alpha = 0
	endif
	ExtendCrc Highway_2D <player_text> out = highway
	if ScreenElementExists id = <highway>
		SetScreenElementProps id = <highway> rgba = ($highway_normal)
	endif
	spawnscriptnow Kill_Highway_Star_Power_Effect params = { player = ($<player_status>.player) }
	spawnscriptnow \{Kill_StarPower_Camera}
endscript
Star_Power_Awarded_SFX_container = {
	Command = PlaySound
	Randomness = RandomNoRepeatType
	Sounds = {
		Sound1 = {
			#"0x77399708"
			vol = 90
			pan1x = -0.5000002
			pan1y = 0.8660253
			pan2x = 0.5
			pan2y = 0.8660254
		}
		Sound2 = {
			#"0xee30c6b2"
			vol = 90
			pan1x = -0.5000002
			pan1y = 0.8660253
			pan2x = 0.5
			pan2y = 0.8660254
		}
	}
}
Star_Power_Awarded_SFX_P1_container = {
	Command = PlaySound
	Randomness = RandomNoRepeatType
	Sounds = {
		Sound1 = {
			#"0x77399708"
			vol = 80
			pan1x = -0.762
			pan1y = 0.6470001
			pan2x = -0.448
			pan2y = 0.894
		}
		Sound2 = {
			#"0xee30c6b2"
			vol = 80
			pan1x = -0.762
			pan1y = 0.6470001
			pan2x = -0.448
			pan2y = 0.894
		}
	}
}
Star_Power_Awarded_SFX_P2_container = {
	Command = PlaySound
	Randomness = RandomNoRepeatType
	Sounds = {
		Sound1 = {
			#"0x77399708"
			vol = 80
			pan1x = 0.47
			pan1y = 0.883
			pan2x = 0.728
			pan2y = 0.685
		}
		Sound2 = {
			#"0xee30c6b2"
			vol = 80
			pan1x = 0.47
			pan1y = 0.883
			pan2x = 0.728
			pan2y = 0.685
		}
	}
}
Battle_Power_Awarded_SFX_P1_container = {
	Command = PlaySound
	Randomness = RandomNoRepeatType
	Sounds = {
		Sound1 = {
			#"0x77399708"
			vol = 90
			pan1x = -0.762
			pan1y = 0.6470001
			pan2x = -0.448
			pan2y = 0.894
		}
		Sound2 = {
			#"0xee30c6b2"
			vol = 90
			pan1x = -0.762
			pan1y = 0.6470001
			pan2x = -0.448
			pan2y = 0.894
		}
	}
}
Battle_Power_Awarded_SFX_P2_container = {
	Command = PlaySound
	Randomness = RandomNoRepeatType
	Sounds = {
		Sound1 = {
			#"0x77399708"
			vol = 80
			pan1x = 0.47
			pan1y = 0.883
			pan2x = 0.728
			pan2y = 0.685
		}
		Sound2 = {
			#"0xee30c6b2"
			vol = 80
			pan1x = 0.47
			pan1y = 0.883
			pan2x = 0.728
			pan2y = 0.685
		}
	}
}
star_power_bolt_scale = (3.0, 3.0)
whammy_width_offset1 = 2.2
sidebar_x_scale1 = 0.3
string_scale_y1 = 0.75
widthOffsetFactor2 = 1.33
gem_y_just2 = 0.75
player_two_x_offset = 400
x_offset_p2 = 290
#"0x2b3eb5da" = 0

open_fx_color1_start	=	[255 128 255 255]
open_fx_color1_end		=	[128 0 128 0]
open_fx_color2_start	=	$open_fx_color1_start
open_fx_color2_end		=	$open_fx_color1_end
open_fx_starpower_color1_start	=	[200 255 255 255]
open_fx_starpower_color1_end	=	[0 128 128 0]
open_fx_starpower_color2_start	=	$open_fx_starpower_color1_start
open_fx_starpower_color2_end	=	$open_fx_starpower_color1_end

script StarSequenceFX
	ExtendCrc gem_container ($<player_status>.text) out = container_id
	GetArraySize \{$#"0xd4b50263"}
	Increment \{array_size}
	gem_count = 0
	begin
		if (<gem_count> = 5)
			gem_count = 7
			color = yellow // hack maybe :/
			// gemMutation open injection only applies to button_models global
		endif
		<note> = ($<song>[<array_entry>][(<gem_count> + 1)])
		if (<note> > 0)
			if (<gem_count> = 7)
				gem_count = 2
			endif
			Color = ($gem_colors [<gem_count>])
			if ($<player_status>.lefthanded_button_ups = 1)
				<pos2d> = ($button_up_models.<Color>.left_pos_2d)
				<angle> = ($button_models.<Color>.angle)
			else
				<pos2d> = ($button_up_models.<Color>.pos_2d)
				<angle> = ($button_models.<Color>.left_angle)
			endif
			FormatText checksumName = nameH 'big_bolt_hit%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
			if NOT ScreenElementExists id = <nameH>
				CreateScreenElement {
					Type = SpriteElement
					id = <nameH>
					parent = <container_id>
					material = Note_Hit_Xplosion1
					Pos = <pos2d>
					rot_angle = 0
					Scale = 2.0
					just = [center bottom]
					z_priority = 16
				}
			endif
			FormatText checksumName = name 'big_bolt%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
			CreateScreenElement {
				Type = SpriteElement
				id = <name>
				parent = <container_id>
				material = sys_Big_Bolt01_sys_Big_Bolt01
				rgba = [255 255 255 255]
				Pos = <pos2d>
				rot_angle = <angle>
				Scale = $star_power_bolt_scale
				just = [center bottom]
				z_priority = 6
			}
			FormatText checksumName = fx_id 'big_bolt_particle%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
			Destroy2DParticleSystem id = <fx_id>
			<particle_pos> = (<pos2d> - (0.0, 0.0))
			Create2DParticleSystem {
				id = <fx_id>
				Pos = <particle_pos>
				z_priority = 8.0
				material = sys_Particle_Star01_sys_Particle_Star01
				parent = <container_id>
				start_color = [0 128 255 255]
				end_color = [0 128 128 0]
				start_scale = (0.25, 0.25)
				end_scale = (0.25, 0.25)
				start_angle_spread = 360.0
				min_rotation = -120.0
				max_rotation = 240.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.04
				emit_dir = 0.0
				emit_spread = 44.0
				velocity = 24.0
				friction = (0.0, 66.0)
				time = 2.0
			}
			FormatText checksumName = fx2_id 'big_bolt_particle2%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			<particle_pos> = (<pos2d> - (0.0, 0.0))
			Create2DParticleSystem {
				id = <fx2_id>
				Pos = <particle_pos>
				z_priority = 8.0
				material = sys_Particle_Star02_sys_Particle_Star02
				parent = <container_id>
				start_color = [255 255 255 255]
				end_color = [128 128 128 0]
				start_scale = (0.125, 0.125)
				end_scale = (0.15000000596046448, 0.15000000596046448)
				start_angle_spread = 360.0
				min_rotation = -120.0
				max_rotation = 508.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.07
				emit_dir = 0.0
				emit_spread = 28.0
				velocity = 12.0
				friction = (0.0, 33.0)
				time = 1.0
			}
			FormatText checksumName = fx3_id 'big_bolt_particle3%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			<particle_pos> = (<pos2d> - (0.0, 15.0))
			Create2DParticleSystem {
				id = <fx3_id>
				Pos = <particle_pos>
				z_priority = 8.0
				material = sys_Particle_lnzflare02_sys_Particle_lnzflare02
				parent = <container_id>
				start_color = [255 255 255 255]
				end_color = [0 255 255 0]
				start_scale = (0.5, 0.5)
				end_scale = (0.05000000074505806, 0.05000000074505806)
				start_angle_spread = 360.0
				min_rotation = -500.0
				max_rotation = 500.0
				emit_start_radius = 0.0
				emit_radius = 2.0
				Emit_Rate = 0.05
				emit_dir = 0.0
				emit_spread = 180.0
				velocity = 12.0
				friction = (0.0, 12.0)
				time = 0.5
			}
		endif
		gem_count = (<gem_count> + 1)
	repeat <array_Size>
	wait \{$#"0xe91f8a7f" seconds}
	gem_count = 0
	begin
		if (<gem_count> = 5)
			gem_count = 7
		endif
		<note> = ($<song>[<array_entry>][(<gem_count> + 1)])
		if (<note> > 0)
			if (<gem_count> = 7)
				gem_count = 2
			endif
			FormatText checksumName = name 'big_bolt%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			DestroyScreenElement id = <name>
			FormatText checksumName = fx_id 'big_bolt_particle%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			Destroy2DParticleSystem id = <fx_id> kill_when_empty
			FormatText checksumName = fx2_id 'big_bolt_particle2%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			Destroy2DParticleSystem id = <fx2_id> kill_when_empty
			FormatText checksumName = fx3_id 'big_bolt_particle3%p%e' p = ($<player_status>.text)e = <gem_count> AddToStringLookup = true
			Destroy2DParticleSystem id = <fx3_id> kill_when_empty
			FormatText checksumName = nameH 'big_bolt_hit%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
			DestroyScreenElement id = <nameH>
			wait \{1 gameframe}
		endif
		gem_count = (<gem_count> + 1)
	repeat <array_Size>
endscript
#"0xe91f8a7f" = 0.283333333

Default_SP_FX_Color = {
	White_255a = [ 255 255 255 255 ]
	White_128a = [ 255 255 255 128 ]
	White_64a = [ 255 255 255 64 ]
	White_32a = [ 255 255 255 32 ]
	White_0a = [ 255 255 255 0 ]
	Color1_255a = [ 0 255 255 255 ]
	Color1_128a = [ 0 200 255 128 ]
	Color1_64a = [ 0 255 255 64 ]
	Color1_32a = [ 0 200 255 32 ]
	Color1_0a = [ 0 255 255 0 ]
	Color2_255a = [ 0 0 255 255 ]
	Color2_128a = [ 0 0 255 128 ]
	Color2_64a = [ 0 0 255 64 ]
	Color2_32a = [ 0 0 255 32 ]
	Color2_0a = [ 0 0 255 0 ]
}
script Create_Highway_Star_Power_Effect
	// and i thought i was autistic with my scripts
	//sp_params = Default_SP_FX_Color
	formattext checksumname = player_status 'player%d_status' d = <player>
	//star_power_multiplier = ($<player_status>.star_power_multiplier)
	//if (<star_power_multiplier> >= 6)
		//sp_params = Pandora_SP_FX_Color
		//spawnscriptnow Create_Pandora_RP_FX_LVL2 params = {Player = <Player>}
	//elseif (<star_power_multiplier> >= 3)
		//sp_params = Pandora_SP_FX_Color
		//spawnscriptnow Create_Pandora_RP_FX_LVL1 params = {Player = <Player>}
	//else
	//endif
	AddParams { ($Default_SP_FX_Color) }
	height = ($highway_height)
	Pos = ((0.0, -1.4) * <height>)
	pos2 = ((0.0, 0.9) * <height>)
	if NOT ($current_num_players = 1)
		pos2 = (<pos2> * 1.5)
	endif
	pos2 = ((640.0, 0.0) + <pos2>)
	if ($current_num_players = 1)
		endpos_L = {(140.0, -80.0) relative}
		endpos_R = {(-140.0, -80.0) relative}
		Rot_L = -50
		Rot_R = 50
	else
		endpos_L = {(120.0, -20.0) relative}
		endpos_R = {(-120.0, -20.0) relative}
		Rot_L = -33
		Rot_R = 33
	endif
	FormatText checksumName = cont 'sidebar_container_left%p' p = ($<player_status>.text) AddToStringLookup = true
	FormatText checksumName = namel 'sidebar_Left_SPGlowp%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namel>
	CreateScreenElement {
		Type = SpriteElement
		id = <namel>
		parent = <cont>
		material = sidebar_glow2
		rgba = <Color1_128a>
		Pos = <Pos>
		Scale = (1.5, 4.0)
		rot_angle = 0
		just = [center top]
		z_priority = 12.3000002
	}
	FormatText checksumName = namel2 'sidebar_Left2_SPGlowp%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namel2>
	CreateScreenElement {
		Type = SpriteElement
		id = <namel2>
		parent = <cont>
		material = sidebar_glow2
		rgba = <White_255a>
		Pos = <Pos>
		Scale = (1.5, 4.0)
		rot_angle = 0
		just = [center top]
		z_priority = 12.1999998
	}
	FormatText checksumName = namels1 'sidebar_Left_star01p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namels1>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namel>
		id = <namels1>
		Scale = (-0.25, 0.25)
		Pos = (20.0, 80.0)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = namels2 'sidebar_Left_star02p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namels2>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namel>
		id = <namels2>
		Scale = (-0.1899999976158142, 0.15000000596046448)
		Pos = (20.0, 46.0)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = namels3 'sidebar_Left_star03p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namels3>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namel>
		id = <namels3>
		Scale = (-0.14000000059604645, 0.10000000149011612)
		Pos = (20.0, 22.0)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = cont 'sidebar_container_right%p' p = ($<player_status>.text) AddToStringLookup = true
	FormatText checksumName = namer 'sidebar_Right_SPGlowp%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namer>
	CreateScreenElement {
		Type = SpriteElement
		id = <namer>
		parent = <cont>
		material = sidebar_glow2
		rgba = <Color1_128a>
		Pos = <Pos>
		Scale = (-1.5, 4.0)
		rot_angle = 0
		just = [center top]
		z_priority = 12.3000002
	}
	FormatText checksumName = namer2 'sidebar_Right2_SPGlowp%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namer2>
	CreateScreenElement {
		Type = SpriteElement
		id = <namer2>
		parent = <cont>
		material = sidebar_glow2
		rgba = <White_255a>
		Pos = <Pos>
		Scale = (-1.5, 4.0)
		rot_angle = 0
		just = [center top]
		z_priority = 12.1999998
	}
	FormatText checksumName = namers1 'sidebar_Right_star01p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namers1>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namer>
		id = <namers1>
		Scale = (-0.30000001192092896, 0.2800000011920929)
		Pos = (20.0, 100.0)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = namers2 'sidebar_Right_star02p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namers2>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namer>
		id = <namers2>
		Scale = (-0.20000000298023224, 0.18000000715255737)
		Pos = (20.0, 62.5)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = namers3 'sidebar_Right_star03p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namers3>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namer>
		id = <namers3>
		Scale = (-0.1599999964237213, 0.12000000476837158)
		Pos = (20.0, 33.5)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	FormatText checksumName = namers4 'sidebar_Right_star04p%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namers4>
	CreateScreenElement {
		Type = SpriteElement
		parent = <namer>
		id = <namers4>
		Scale = (-0.10000000149011612, 0.05999999865889549)
		Pos = (20.0, 10.5)
		just = [center center]
		material = sys_Particle_Star02_sys_Particle_Star02
		z_priority = 0.9
		rgba = <Color1_255a>
		preserve_local_orientation = true
	}
	//FormatText checksumName = container_id 'fretbar_containerp%p' p = <Player> AddToStringLookup = true
	ExtendCrc gem_container ($<player_status>.text) out = container_id
	FormatText checksumName = namec 'sidebar_Center_SPRushp%p' p = <Player> AddToStringLookup = true
	DestroyScreenElement id = <namec>
	CreateScreenElement {
		Type = SpriteElement
		id = <namec>
		parent = <container_id>
		material = sidebar_glow2
		rgba = <Color1_0a>
		Pos = <pos2>
		rot_angle = 0
		Scale = (4.0, 2.5)
		just = [center top]
		z_priority = 1.1
	}
	/*FormatText checksumName = fxsr1 'sidebar_star01Rp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsr1>
	Create2DParticleSystem {
		id = <fxsr1>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namers1>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.800000011920929, 0.5)
		end_scale = (0.800000011920929, 0.5)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsr2 'sidebar_star02Rp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsr2>
	Create2DParticleSystem {
		id = <fxsr2>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namers2>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.800000011920929, 0.6000000238418579)
		end_scale = (0.800000011920929, 0.6000000238418579)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0.0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsr3 'sidebar_star03Rp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsr3>
	Create2DParticleSystem {
		id = <fxsr3>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namers3>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.6000000238418579, 0.30000001192092896)
		end_scale = (0.6000000238418579, 0.30000001192092896)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0.0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsr4 'sidebar_star04Rp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsr4>
	Create2DParticleSystem {
		id = <fxsr4>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namers4>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.30000001192092896, 0.20000000298023224)
		end_scale = (0.30000001192092896, 0.20000000298023224)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0.0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsl1 'sidebar_star01Lp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsl1>
	Create2DParticleSystem {
		id = <fxsl1>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namels1>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (1.0, 0.6000000238418579)
		end_scale = (1.0, 0.6000000238418579)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsl2 'sidebar_star02Lp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsl2>
	Create2DParticleSystem {
		id = <fxsl2>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namels2>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.800000011920929, 0.4000000059604645)
		end_scale = (0.800000011920929, 0.4000000059604645)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0.0
		friction = (0.0, 0.0)
		time = 0.25
	}
	FormatText checksumName = fxsl3 'sidebar_star03Lp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fxsl3>
	Create2DParticleSystem {
		id = <fxsl3>
		Pos = (0.0, 0.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namels3>
		start_color = <Color1_128a>
		end_color = <Color2_0a>
		start_scale = (0.6000000238418579, 0.30000001192092896)
		end_scale = (0.6000000238418579, 0.4000000059604645)
		start_angle_spread = 0
		min_rotation = 18
		max_rotation = 18
		emit_start_radius = 0
		emit_radius = 0
		Emit_Rate = 0.1
		emit_dir = 0.0
		emit_spread = 0
		velocity = 0.0
		friction = (0.0, 0.0)
		time = 0.25
	}*///
	if ScreenElementExists id = <namel>
		DoScreenElementMorph id = <namel> Pos = <Pos> Scale = (4.0, 4.0) time = 0.25
	endif
	if ScreenElementExists id = <namel2>
		DoScreenElementMorph id = <namel2> Pos = <Pos> Scale = (1.0, 4.0) rgba = <Color1_128a> time = 0.25
	endif
	if ScreenElementExists id = <namer>
		DoScreenElementMorph id = <namer> Pos = <Pos> Scale = (-4.0, 4.0) time = 0.25
	endif
	if ScreenElementExists id = <namer2>
		DoScreenElementMorph id = <namer2> Pos = <Pos> Scale = (-1.0, 4.0) rgba = <Color1_128a> time = 0.25
	endif
	if ScreenElementExists id = <namec>
		DoScreenElementMorph id = <namec> Pos = <pos2> Scale = (8.0, 2.4000000953674316) time = 0.25
	endif
	wait \{0.25 seconds}
	if ScreenElementExists id = <namel>
		DoScreenElementMorph id = <namel> alpha = 0 time = 0.5 Pos = <endpos_L> rot_angle = <Rot_L>
	endif
	if ScreenElementExists id = <namel2>
		DoScreenElementMorph id = <namel2> rgba = <Color2_0a> time = 0.5
	endif
	if ScreenElementExists id = <namer>
		DoScreenElementMorph id = <namer> rgba alpha = 0 time = 0.5 Pos = <endpos_R> rot_angle = <Rot_R>
	endif
	if ScreenElementExists id = <namer2>
		DoScreenElementMorph id = <namer2> rgba = <Color2_0a> time = 0.5
	endif
	if ScreenElementExists id = <namec>
		DoScreenElementMorph id = <namec> rgba = <Color1_128a> time = 0.5
	endif
	wait \{0.25 seconds}
	FormatText checksumName = fx3 'sidebar_Center3_SPFXp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fx3>
	/*Create2DParticleSystem {
		id = <fx3>
		Pos = (0.0, 100.0)
		z_priority = 12
		material = sys_Particle_Star02_sys_Particle_Star02
		parent = <namec>
		start_color = <White_64a>
		end_color = <Color1_0a>
		start_scale = (0.25, 0.25)
		end_scale = (0.5, 0.5)
		start_angle_spread = 360.0
		min_rotation = 333
		max_rotation = -333
		emit_start_radius = 6
		emit_radius = 336
		Emit_Rate = 0.05
		emit_dir = 180.0
		emit_spread = 33.0
		velocity = 5.0999999
		friction = (0.0, -3.0)
		time = 1.0
	}
	FormatText checksumName = fx2 'sidebar_Center2_SPFXp%p' p = <Player> AddToStringLookup = true
	Destroy2DParticleSystem id = <fx2>
	Create2DParticleSystem {
		id = <fx2>
		Pos = (0.0, 100.0)
		z_priority = 12
		material = sys_Particle_Spark01_sys_Particle_Spark01
		parent = <namec>
		start_color = <White_64a>
		end_color = <Color1_0a>
		start_scale = (2.25, 2.25)
		end_scale = (0.25, 0.25)
		start_angle_spread = 360.0
		min_rotation = 333
		max_rotation = -333
		emit_start_radius = 0
		emit_radius = 777
		Emit_Rate = 0.05
		emit_dir = 0.0
		emit_spread = 33.0
		velocity = 1.1
		friction = (0.0, 12.0)
		time = 1.0
	}*///
	wait \{0.25 seconds}
	//Destroy2DParticleSystem kill_when_empty id = <fx2>
	//Destroy2DParticleSystem kill_when_empty id = <fx3>
	//Destroy2DParticleSystem kill_when_empty id = <fxsr1>
	//Destroy2DParticleSystem kill_when_empty id = <fxsr2>
	//Destroy2DParticleSystem kill_when_empty id = <fxsr3>
	//Destroy2DParticleSystem kill_when_empty id = <fxsr4>
	//Destroy2DParticleSystem kill_when_empty id = <fxsl1>
	//Destroy2DParticleSystem kill_when_empty id = <fxsl2>
	//Destroy2DParticleSystem kill_when_empty id = <fxsl3>
	wait \{0.25 seconds}
	DestroyScreenElement id = <namel>
	DestroyScreenElement id = <namer>
	if ScreenElementExists id = <namel2>
		/*<namel2> ::Obj_SpawnScriptNow*/
		RunScriptOnScreenElement id = <namel2> pulse_SP_color params = {Player = <Player>}
	endif
endscript

script pulse_SP_color
	sp_params = Default_SP_FX_Color
	White_255a = (($<sp_params>).White_255a)
	White_128a = (($<sp_params>).White_128a)
	White_64a = (($<sp_params>).White_64a)
	White_32a = (($<sp_params>).White_32a)
	White_0a = (($<sp_params>).White_0a)
	Color1_255a = (($<sp_params>).Color1_255a)
	Color1_128a = (($<sp_params>).Color1_128a)
	Color1_64a = (($<sp_params>).Color1_64a)
	Color1_32a = (($<sp_params>).Color1_32a)
	Color1_0a = (($<sp_params>).Color1_0a)
	Color2_255a = (($<sp_params>).Color2_255a)
	Color2_128a = (($<sp_params>).Color2_128a)
	Color2_64a = (($<sp_params>).Color2_64a)
	Color2_32a = (($<sp_params>).Color2_32a)
	Color2_0a = (($<sp_params>).Color2_0a)
	begin
		FormatText checksumName = namer2 'sidebar_Right2_SPGlowp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namel2>
			DoScreenElementMorph id = <namel2> rgba = <Color1_64a> time = 0.5
		endif
		FormatText checksumName = namel2 'sidebar_Left2_SPGlowp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namer2>
			DoScreenElementMorph id = <namer2> rgba = <Color1_64a> time = 0.5
		endif
		FormatText checksumName = namec 'sidebar_Center_SPRushp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namec>
			DoScreenElementMorph id = <namec> rgba = <Color1_32a> time = 0.5
		endif
		wait \{0.5 seconds}
		FormatText checksumName = namer2 'sidebar_Right2_SPGlowp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namer2>
			DoScreenElementMorph id = <namer2> rgba = <Color1_255a> time = 0.5
		endif
		FormatText checksumName = namel2 'sidebar_Left2_SPGlowp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namel2>
			DoScreenElementMorph id = <namel2> rgba = <Color1_255a> time = 0.5
		endif
		FormatText checksumName = namec 'sidebar_Center_SPRushp%p' p = <Player> AddToStringLookup = true
		if ScreenElementExists id = <namec>
			DoScreenElementMorph id = <namec> rgba = <Color1_64a> time = 0.5
		endif
		wait \{0.5 seconds}
	repeat
endscript

script Kill_Highway_Star_Power_Effect
	//spawnscriptnow kill_Pandora_RP_FX params = {Player = <Player>}
	FormatText checksumName = namer2 'sidebar_Right2_SPGlowp%p' p = <Player> AddToStringLookup = true
	if ScreenElementExists id = <namer2>
		DoScreenElementMorph id = <namer2> alpha = 0 time = 0.5
	endif
	FormatText checksumName = namel2 'sidebar_Left2_SPGlowp%p' p = <Player> AddToStringLookup = true
	if ScreenElementExists id = <namel2>
		DoScreenElementMorph id = <namel2> alpha = 0 time = 0.5
	endif
	FormatText checksumName = namec 'sidebar_Center_SPRushp%p' p = <Player> AddToStringLookup = true
	if ScreenElementExists id = <namec>
		DoScreenElementMorph id = <namec> alpha = 0 time = 0.5
	endif
	wait \{0.5 seconds}
	DestroyScreenElement id = <namec>
	DestroyScreenElement id = <namel2>
	DestroyScreenElement id = <namer2>
endscript

script complete_star
	SetSpawnInstanceLimits \{Max = 1 management = ignore_spawn_request}
	wait \{0.3 seconds}
	SoundEvent \{event = Star_SFX}
	ExtendCrc HUD2D_score_star_1 <player_text> out = parent_cont
	if NOT ScreenElementExists id = <parent_cont>
		return
	endif
	//id = hud_star_meter_id
	//if NOT <id> ::Desc_ResolveAlias name = alias_Star_Earn_FX param = Parent_Cont
		//return
	//endif
	colorin = [255 200 0 255]
	colorout = [0 0 0 255]
	DestroyScreenElement \{id = Star_Meter_Counter_glow01}
	DestroyScreenElement \{id = Star_Meter_Counter_glow02}
	pos = (56.0, 48.0)
	CreateScreenElement {
		Type = SpriteElement
		id = Star_Meter_Counter_glow01
		parent = <Parent_Cont>
		material = tubeglow02
		rgba = [255 200 64 255]
		alpha = 0
		dims = (228.0, 228.0)
		Pos = <pos>
		Scale = (1.0, 1.0)
		rot_angle = 0
		just = [center center]
		pos_anchor = [center center]
		z_priority = 29
	}
	CreateScreenElement {
		Type = SpriteElement
		id = Star_Meter_Counter_glow02
		parent = <Parent_Cont>
		material = tubeglow02
		rgba = [255 200 64 255]
		alpha = 0
		dims = (128.0, 128.0)
		Pos = <pos>
		Scale = (1.0, 1.0)
		rot_angle = 0
		just = [center center]
		pos_anchor = [center center]
		z_priority = 30
	}
	ExtendCrc starflash_0 <player_text> out = RP_FX01
	Create2DParticleSystem {
		Pos = <pos>
		z_priority = 29
		material = sys_Particle_lnzflare02_sys_Particle_lnzflare02
		parent = <Parent_Cont>
		start_color = [255 255 128 255]
		end_color = [255 128 0 0]
		start_scale = (0.25, 0.25)
		end_scale = (1.0, 1.0)
		start_angle_spread = 0.0
		min_rotation = -180
		max_rotation = 360
		emit_start_radius = 6
		emit_radius = 6
		Emit_Rate = 0.00151
		emit_dir = 0.0
		emit_spread = 360.0
		velocity = 6.1000004
		friction = (0.0, 12.0)
		id = <RP_FX01>
		time = 0.2
	}
	wait \{0.1 Seconds}
	ExtendCrc starflash_1 <player_text> out = RP_FX02
	Create2DParticleSystem {
		parent = <Parent_Cont>
		Pos = <pos>
		z_priority = 29
		material = sys_Particle_Spark01_sys_Particle_Spark01
		start_color = <colorin>
		end_color = [255 255 255 0]
		start_scale = (0.5, 0.5)
		end_scale = (1.5, 1.5)
		start_angle_spread = 360.0
		min_rotation = 0
		max_rotation = 360
		emit_start_radius = 10
		emit_radius = 0.5
		Emit_Rate = 0.005
		emit_dir = 0.0
		emit_spread = 360.0
		velocity = 2
		friction = (-1.505, 1.5)
		id = <RP_FX02>
		time = 0.5
	}
	ExtendCrc starflash_2 <player_text> out = RP_FX03
	Create2DParticleSystem {
		parent = <Parent_Cont>
		Pos = <pos>
		z_priority = 30
		material = sys_Particle_Spark01_sys_Particle_Spark01
		start_color = [255 255 255 255]
		end_color = <colorout>
		start_scale = (1.5, 1.5)
		end_scale = (5.5, 0.15)
		start_angle_spread = 360.0
		min_rotation = 0
		max_rotation = 360
		emit_start_radius = 10
		emit_radius = 0.5
		Emit_Rate = 0.01
		emit_dir = 0.0
		emit_spread = 360.0
		velocity = 4
		friction = (0.0, 0.0)
		id = <RP_FX03>
		time = 0.3
	}
	Destroy2DParticleSystem id = <RP_FX01> kill_when_empty
	if ScreenElementExists \{id = Star_Meter_Counter_glow01}
		SetScreenElementProps \{id = Star_Meter_Counter_glow01 alpha = 1 time = 0.1}
		SetScreenElementProps \{id = Star_Meter_Counter_glow02 alpha = 1 time = 0.1}
	endif
	wait \{0.25 Seconds}
	if ScreenElementExists \{id = Star_Meter_Counter_glow01}
		SetScreenElementProps \{id = Star_Meter_Counter_glow01 alpha = 0 time = 0.3}
		SetScreenElementProps \{id = Star_Meter_Counter_glow02 alpha = 0 time = 0.3}
	endif
	//wait \{0.3 seconds}
	DestroyScreenElement \{id = Star_Meter_Counter_glow01}
	Destroy2DParticleSystem id = <RP_FX02> kill_when_empty
	Destroy2DParticleSystem id = <RP_FX03> kill_when_empty
endscript

script rock_back_and_forth_star_meter
endscript

script hud_flip_note_streak_num
endscript

script hit_note_fx
	if ($disable_particles > 1)
		return
	endif
	NoteFX <...>
	if ($disable_particles < 2)
		Pos = (<Pos> + (0.0, 20.0))
		SetScreenElementProps id = <fx_id> Pos = <Pos> Scale = (1.4, 1.4) relative_scale
	endif
	if ($disable_particles = 0)
		wait 100 #"0x8d07dc15"
		Destroy2DParticleSystem id = <particle_id> kill_when_empty
	endif
	if ($disable_particles = 1)
		Destroy2DParticleSystem id = <particle_id>
		wait 100 #"0x8d07dc15"
	endif
	if ($disable_particles < 2)
		wait 167 #"0x8d07dc15"
		if (ScreenElementExists id = <fx_id>)
			DestroyScreenElement id = <fx_id>
		endif
	endif
endscript
hit_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		255
		128
		64
		200
	]
	end_color = [
		255
		128
		0
		0
	]
	start_scale = (1.0, 1.5)
	end_scale = (0.014999999664723873, 0.029999999329447746)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 30.0
	emit_radius = 12.0
	Emit_Rate = 0.025
	emit_dir = 0.0
	emit_spread = 80.0
	velocity = 6.0
	friction = (0.0, 100.0)
	time = 0.5
}
star_hit_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		128
		255
		255
		200
	]
	end_color = [
		128
		255
		255
		0
	]
	start_scale = (1.0, 1.5)
	end_scale = (0.014999999664723873, 0.029999999329447746)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 30.0
	emit_radius = 12.0
	Emit_Rate = 0.025
	emit_dir = 0.0
	emit_spread = 80.0
	velocity = 6.0
	friction = (0.0, 100.0)
	time = 0.5
}
whammy_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		255
		128
		0
		255
	]
	end_color = [
		255
		0
		0
		0
	]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	Emit_Rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.5
}
sidebar_normal0 = [ 255 255 255 255 ]
sidebar_normal1 = $#"0xc9027eac"
sidebar_starready0 = $#"0xc9027eac"
sidebar_starready1 = $#"0xc9027eac"
sidebar_dying0 = [ 255 255 255 255 ]
sidebar_dying1 = [ 255 80 80 255 ]
sidebar_starpower0 = $#"0xc9027eac"
sidebar_starpower1 = $#"0xc9027eac"
highway_normal = [ 255 255 255 255 ]
highway_dying = [ 255 0 0 255 ]
highway_starpower = [ 64 255 255 255 ]
#"0x87912238" = [ 255 0 0 255 ]
gem_y_just1 = 0.75
sidebar_x_scale1 = 0.32
widthOffsetFactor2 = 1.33
string_scale_y1 = 0.75
gem_end_scale2 = 0.75
string_scale_y2 = 0.6

script show_star_power_ready
	if ($game_mode = p2_career || $game_mode = p2_coop)
		<player_status> = player1_status
	endif
	SoundEvent \{event = Star_Power_Ready_SFX}
	spawnscriptnow rock_meter_star_power_on params = {player_status = <player_status>}
endscript

script set_sidebar_flash
	if ($Cheat_PerformanceMode = 1)
		return
	endif
	ExtendCrc highway_pulse_black_ ($<player_status>.text) out = pulse
	if ($<pulse> = 1)
		return
	endif
	// about 0.005ms slower than original code
	ExtendCrc Highway_2D ($<player_status>.text) out = id
	sp = ($<player_status>.star_power_used = 1)
	if (<dying> = 1)
		Ternary \{$beat_flip a = highway_normal b = highway_dying}
		if (<sp>)
			if ($beat_flip)
				ternary = highway_starpower
			endif
		endif
	else
		Ternary <sp> a = highway_starpower b = highway_normal
	endif
	SetScreenElementProps id = <id> rgba = ($<ternary>)
endscript

script #"0x99719b14"
	if NOT (<last_health> = ($<player_status>.current_health))
		<last_health> = ($<player_status>.current_health)
		ExtendCrc #"0xcccf93ce" <player_text> out = Needle
		if (ScreenElementExists id = <Needle>)
			health = (0.5 * $<player_status>.current_health)
			c1 = (2 - (4 * $#"0xb8d68ee1"))
			c2 = ((4 * $#"0xb8d68ee1")- 1)
			#"0x5d60e3ad" = (((<c1> * <health>)* <health>)+ (<c2> * <health>))
			#"0x18b232c8" = ($#"0xf81f86d7" - $#"0xfbec6698")
			Pos = ($#"0xfbec6698" + (<#"0x5d60e3ad"> * <#"0x18b232c8">))
			Scale = ((($#"0x2ce68ed8" - $#"0xfb0d3c99")* <#"0x5d60e3ad">)+ $#"0xfb0d3c99")
			SetScreenElementProps id = <Needle> Pos = <Pos>
			SetScreenElementProps id = <Needle> Scale = <Scale>
			if (<health> >= (0.5 * $health_medium_good))
				rgba = $#"0xb6ac2f81"
			elseif (<health> >= (0.5 * $health_poor_medium))
				rgba = $#"0xdcf09d3c"
			else
				rgba = $#"0x8fb6f5f6"
			endif
			ExtendCrc #"0x42b328e7" <player_text> out = #"0x15834eea"
			SetScreenElementProps id = <#"0x15834eea"> rgba = <rgba>
		endif
		return last_health = <last_health>
	endif
endscript

script #"0x337a7967"
	if NOT ($game_mode = p2_career | $game_mode = p2_coop)
		current_run = ($<player_status>.current_run)
		total_notes = ($<player_status>.total_notes)
		notes_hit = ($<player_status>.notes_hit)
	else
		current_run = ($player1_status.current_run + $player2_status.current_run)
		total_notes = ($player1_status.total_notes + $player2_status.total_notes)
		notes_hit = ($player1_status.notes_hit + $player2_status.notes_hit)
	endif
	if NOT (<last_run> = <current_run>)
		last_run = <current_run>
		if (<last_run> >= 24)
			FormatText textname = text '%d' d = <last_run>
			SetScreenElementProps id = <streak_id> text = <text>
		endif
	endif
	if (<no_fc> = 0)
		if NOT (<last_total> = <total_notes>)
			last_total = <total_notes>
			if (<notes_hit> < <total_notes>)
				#"0x053b3781" <...>
			endif
		endif
	endif
	last_notes = ($player1_status.total_notes)
	if NOT ($game_mode = p2_career | $game_mode = p2_coop)
		total_score = ($<player_status>.score)
	else
		total_score = ($player1_status.score + $player2_status.score)
	endif
	// WTF happened here
	if NOT (<last_score> = <total_score>)
		last_score = <total_score>
		if ScreenElementExists id = <score_id>
			CastToInteger \{last_score}
			FormatText textname = text '%d' d = <last_score> usecommas
			SetScreenElementProps id = <score_id> scale = 1.1 text = <text>
		endif
		if ScreenElementExists id = <#"0xae091b7d">
			base_score = ($<player_status>.base_score)
			score = ($<player_status>.score)
			#"0x039f4780" = (<score> / <base_score>)
			if (<#"0x039f4780"> >= 2.8)
				stars = 5
				Progress = 1.0
			elseif (<#"0x039f4780"> >= 2.0)
				stars = 4
				Progress = ((<#"0x039f4780"> - 2.0)/ 0.8)
			elseif (<#"0x039f4780"> >= 0.9)
				stars = 3
				Progress = ((<#"0x039f4780"> - 0.9)/ 1.1)
			elseif (<#"0x039f4780"> >= 0.65)
				stars = 2
				Progress = ((<#"0x039f4780"> - 0.65)/ 0.25)
			elseif (<#"0x039f4780"> >= 0.1)
				stars = 1
				Progress = ((<#"0x039f4780"> - 0.1)/ 0.55)
			else
				stars = 0
				Progress = (<#"0x039f4780"> / 0.1)
			endif
			if ($<player_status>.max_notes > 0)
				#"0x593a11c3" = (100 * ($<player_status>.notes_hit / $<player_status>.max_notes))
				if (<#"0x593a11c3"> = 100)
					stars = 6
				endif
			endif
			dims = ((($#"0xb9828f7c" * <Progress>)* (1.0, 0.0))+ ($#"0xd5189206" * (0.0, 1.0)))
			SetScreenElementProps id = <#"0xae091b7d"> dims = <dims>
			end_pos = ((($#"0xb9828f7c" * <Progress>)* (1.0, 0.0))+ $#"0x1d41c861")
			ExtendCrc #"0x4ae39f0b" <player_text> out = #"0x52d3e74a"
			SetScreenElementProps id = <#"0x52d3e74a"> Pos = <end_pos>
			if NOT (<last_stars> = <stars>)
				<old_stars> = <last_stars>
				<last_stars> = <stars>
				FormatText checksumName = #"0x295fafd5" 'HUD2D_score_star_%d' d = <stars>
				ExtendCrc <#"0x295fafd5"> <player_text> out = #"0x295fafd5"
				SetScreenElementProps id = <#"0x295fafd5"> alpha = 1
				if NOT (<old_stars> = -1)
					spawnscriptnow complete_star params = { <...> }
				endif
			endif
		endif
	endif
	if ScreenElementExists id = <#"0x18b23fd9">
		if ($game_mode = training)
			completion = 1.0
		else
			time = ($current_time - $current_starttime)
			completion = (<time> / ($#"0x2b3eb5da" / 1000.0))
		endif
		dims = ((($#"0xd22c1054" * <completion>)* (1.0, 0.0))+ ($#"0xe0c69463" * (0.0, 1.0)))
		SetScreenElementProps id = <#"0x18b23fd9"> dims = <dims>
		end_pos = ((($#"0xd22c1054" * <completion>)* (1.0, 0.0))+ $#"0x9b53cde3")
		ExtendCrc #"0x766026d8" <player_text> out = #"0x52d3e74a"
		SetScreenElementProps id = <#"0x52d3e74a"> Pos = <end_pos>
	endif
	return old_stars = <old_stars> last_stars = <last_stars> last_run = <last_run> last_score = <last_score>
endscript

script #"0x053b3781"
	ExtendCrc #"0x3a74478c" <player_text> out = #"0x15834eea"
	if ScreenElementExists id = <#"0x15834eea">
		SetScreenElementProps id = <#"0x15834eea"> alpha = 0
	endif
	ExtendCrc #"0x0500c035" <player_text> out = #"0xa1fef351"
	if ScreenElementExists id = <#"0xa1fef351">
		rgba = $#"0x4ca1aa8d"
		SetScreenElementProps id = <#"0xa1fef351"> rgba = <rgba>
	endif
	return \{no_fc = 1}
endscript

script hud_sp_ready_flash
	Destroy2DParticleSystem id = <sp_ready_flash>
	Create2DParticleSystem {
		id = <sp_ready_flash>
		Pos = (32.0,32.0)
		z_priority = 8.0
		material = sys_Particle_Spark01_sys_Particle_Spark01
		parent = <#"0xe0a18aea">
		start_color = [255 255 255 255]
		end_color = [0 255 255 0]
		start_scale = (1.25, 1.25)
		end_scale = (0.25, 0.25)
		start_angle_spread = 360.0
		min_rotation = 0
		max_rotation = 0
		emit_start_radius = 3
		emit_radius = 3
		Emit_Rate = 0.01
		emit_dir = 66.0
		emit_spread = 180.0
		velocity = 3.3
		friction = (0.0, 12.0)
		time = 0.551
	}
	wait \{0.25 seconds}
	Destroy2DParticleSystem id = <sp_ready_flash> kill_when_empty
endscript
script #"0xf0ca5a38"
	if NOT (<last_sp> = $<player_status>.star_power_amount)
		<last_sp> = ($<player_status>.star_power_amount)
		if ScreenElementExists id = <#"0x3552289a">
			alpha = ($<player_status>.star_power_amount > 0.0)
			SetScreenElementProps id = <#"0x3552289a"> alpha = <alpha>
		endif
		if ScreenElementExists id = <#"0xe0a18aea">
			if (<last_sp> >= 50.0 || $<player_status>.star_power_used = 1)
				alpha = 1
				if (<got_sp> = 0)
					got_sp = 1
				endif
			else
				alpha = 0
				got_sp = 0
			endif
			if (<got_sp> = 1 && $<player_status>.star_power_used = 0)
				got_sp = 2
				spawnscriptnow hud_sp_ready_flash params = { <...> }
			endif
			amount = (<last_sp> / 100.0)
			Pos = (<amount> * (-5.0, -200.0))
			Scale = (1.1 - (<amount> * 0.3))
			SetScreenElementProps id = <#"0xe0a18aea"> alpha = <alpha> Pos = <Pos> Scale = <Scale>
		endif
	endif
	return last_sp = <last_sp> got_sp = <got_sp>
endscript

script update_score_fast
	if ($hudless = 1)
		return
	endif
	UpdateScoreFastInit player_status = <player_status>
	last_sp = -1.0
	got_sp = 0
	last_health = -1.0
	last_score = -1.0
	last_stars = -1
	last_run = -1
	last_total = 0
	old_stars = -1
	no_fc = 0
	player_text = ($<player_status>.text)
	get_song_end_time \{song = $current_song}
	
	ExtendCrc starpower_container_left <player_text> out = name
	if ScreenElementExists id = <name>
		DestroyScreenElement id = <name>
	endif
	ExtendCrc starpower_container_right <player_text> out = name
	if ScreenElementExists id = <name>
		DestroyScreenElement id = <name>
	endif
	
	
	Change #"0x2b3eb5da" = <total_end_time>
	ExtendCrc #"0x60199acb" <player_text> out = #"0x3552289a"
	ExtendCrc HUD2D_SP_glow_end <player_text> out = #"0xe0a18aea"
	ExtendCrc particles_SP_ready_flash <player_text> out = sp_ready_flash
	ExtendCrc #"0x0500c035" <player_text> out = #"0xae091b7d"
	ExtendCrc #"0x95a37ec5" <player_text> out = #"0x18b23fd9"
	if ($<player_status>.player = 2 & ($game_mode = p2_coop | $game_mode = p2_career))
		player_text = ($player1_status.text)
		// was crashing in co-op and battle for streak text
	endif
	dont_update_score = ($game_mode = p2_battle | $boss_battle = 1)
	ExtendCrc HUD2D_Note_Streak_Text <player_text> out = streak_id
	ExtendCrc HUD2D_Score_Text <player_text> out = score_id
	begin
		GetSongTimeMs
		UpdateScoreFastPerFrame player_status = <player_status> time = <time>
		#"0x99719b14" <...>
		if NOT (<dont_update_score>)
			#"0x337a7967" <...>
		endif
		#"0xf0ca5a38" <...>
		wait \{1 gameframe}
	repeat
endscript

script create_2d_hud_elements \{player_text = 'p1'}
	Change \{g_flash_red_going_p1 = 0}
	Change \{g_flash_red_going_p2 = 0}
	Change \{old_animate_bulbs_star_power_p1 = 0.0}
	Change \{old_animate_bulbs_star_power_p2 = 0.0}
	GetArraySize (($g_hud_2d_struct_used).elements)
	parent_scale = (($g_hud_2d_struct_used).Scale)
	old_parent = <parent>
	parent_z = (($g_hud_2d_struct_used).z)
	i = 0
	begin
		just = [left top]
		myscale = 1.0
		zoff = 0.0
		rot = 0.0
		alpha = 1
		pos_off = (0.0, 0.0)
		blend = 0
		AddParams (($g_hud_2d_struct_used).elements [<i>])
		element_struct = (($g_hud_2d_struct_used).elements [<i>])
		if StructureContains structure = <element_struct> parent_container
			if StructureContains structure = <element_struct> element_parent
				ExtendCrc <element_parent> <player_text> out = container_parent
				if NOT ScreenElementExists id = <container_parent>
					ExtendCrc <element_parent> 'p1' out = container_parent
				endif
			else
				container_parent = <old_parent>
			endif
			container_pos = (0.0, 0.0)
			if StructureContains structure = <element_struct> pos_type
				<container_pos> = (($g_hud_2d_struct_used).<pos_type>)
				if (<player_text> = 'p2')
					ExtendCrc <pos_type> '_p2' out = new_pos_type
					<container_pos> = (($g_hud_2d_struct_used).<new_pos_type>)
				else
					if ($current_num_players = 2)
						ExtendCrc <pos_type> '_p1' out = new_pos_type
						<container_pos> = (($g_hud_2d_struct_used).<new_pos_type>)
					endif
				endif
			endif
			if StructureContains structure = <element_struct> note_streak_bar
				if StructureContains structure = ($g_hud_2d_struct_used)offscreen_note_streak_bar_off
					<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off))
				else
					if (<player_text> = 'p1')
						<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off_p1))
					else
						<container_pos> = (<container_pos> + (($g_hud_2d_struct_used).offscreen_note_streak_bar_off_p2))
					endif
				endif
			endif
			<container_pos> = (<container_pos> + <pos_off>)
			ExtendCrc <element_id> <player_text> out = new_id
			<create_it> = 1
			if StructureContains structure = <element_struct> create_once
				ExtendCrc <element_id> 'p1' out = p1_id
				if ScreenElementExists id = <p1_id>
					<create_it> = 0
				endif
			endif
			if ((StructureContains structure = <element_struct> rot_p2)& (<player_text> = 'p2'))
				<rot> = <rot_p2>
			endif
			if (<create_it>)
				CreateScreenElement {
					Type = ContainerElement
					parent = <container_parent>
					id = <new_id>
					Pos = <container_pos>
					rot_angle = <rot>
					z_priority = <z_off>
				}
			endif
			parent = <new_id>
		endif
		if StructureContains structure = <element_struct> container
			if NOT StructureContains structure = <element_struct> parent_container
				ExtendCrc <element_id> <player_text> out = new_id
				ExtendCrc <element_parent> <player_text> out = myparent
				if StructureContains structure = <element_struct> small_bulb
					scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).small_bulb_scale))
				else
					scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).big_bulb_scale))
				endif
				if ((StructureContains structure = <element_struct> pos_off_p2)& (<player_text> = 'p2'))
					<pos_off> = <pos_off_p2>
				endif
				<create_it> = 1
				if StructureContains structure = <element_struct> create_once
					ExtendCrc <element_id> 'p1' out = p1_id
					if ScreenElementExists id = <p1_id>
						<create_it> = 0
					endif
				endif
				if (<create_it>)
					CreateScreenElement {
						Type = SpriteElement
						parent = <myparent>
						id = <new_id>
						texture = <texture>
						Pos = <pos_off>
						just = <just>
						rgba = [255 255 255 255]
						rot_angle = <rot>
						z_priority = <zoff>
						alpha = <alpha>
						dims = <scaled_dims>
					}
					<new_id> ::SetTags morph = 0
					<new_id> ::SetTags index = <i>
					<parent> = <id>
					<rot> = 0.0
					<Pos> = (0.0, 0.0)
					if StructureContains structure = <element_struct> initial_pos
						if ((StructureContains structure = <element_struct> initial_pos_p2)& (<player_text> = 'p2'))
							SetScreenElementProps id = <new_id> Pos = <initial_pos_p2>
							<new_id> ::SetTags final_pos = <pos_off_p2>
							<new_id> ::SetTags initial_pos = <initial_pos_p2>
							<new_id> ::SetTags morph = 1
						else
							SetScreenElementProps id = <new_id> Pos = <initial_pos>
							<new_id> ::SetTags final_pos = <pos_off>
							<new_id> ::SetTags initial_pos = <initial_pos>
							<new_id> ::SetTags morph = 1
						endif
					endif
				endif
			endif
		else
			if NOT StructureContains structure = <element_struct> parent_container
				ExtendCrc <element_id> <player_text> out = new_id
				if StructureContains structure = <element_struct> initial_pos
					<pos_off> = <initial_pos>
				endif
				if StructureContains structure = <element_struct> battle_pos
					if (<player_text> = 'p2')
						<container_pos> = (($g_hud_2d_struct_used).rock_pos_p2)
						ExtendCrc <pos_type> '_p2' out = new_pos_type
						<pos_off> = ((($g_hud_2d_struct_used).<new_pos_type>))
					else
						<container_pos> = (($g_hud_2d_struct_used).rock_pos_p1)
						ExtendCrc <pos_type> '_p1' out = new_pos_type
						<pos_off> = ((($g_hud_2d_struct_used).<new_pos_type>))
					endif
				endif
				ExtendCrc <element_parent> <player_text> out = myparent
				flags = {}
				if StructureContains structure = <element_struct> flags
					if StructureContains structure = (<element_struct>.flags)flip_v
						if StructureContains structure = (<element_struct>.flags)p1
							if (<player_text> = 'p1')
								<flags> = flip_v
							endif
						endif
					endif
					if StructureContains structure = (<element_struct>.flags)flip_h
						if StructureContains structure = (<element_struct>.flags)p1
							if (<player_text> = 'p1')
								<flags> = flip_h
							endif
						endif
						if StructureContains structure = (<element_struct>.flags)p2
							if (<player_text> = 'p2')
								<flags> = flip_h
							endif
						endif
					endif
				endif
				mydims = {}
				if StructureContains structure = <element_struct> dims
					<mydims> = <dims>
				endif
				<create_it> = 1
				if StructureContains structure = <element_struct> create_once
					ExtendCrc <element_id> 'p1' out = p1_id
					if ScreenElementExists id = <p1_id>
						<create_it> = 0
					endif
				endif
				if ((StructureContains structure = <element_struct> initial_pos_p2)& (<player_text> = 'p2'))
					<pos_off> = <initial_pos_p2>
				elseif ((StructureContains structure = <element_struct> pos_off_p2)& (<player_text> = 'p2'))
					<pos_off> = <pos_off_p2>
				endif
				my_rgba = [255 255 255 255]
				if (StructureContains structure = <element_struct> rgba)
					<my_rgba> = <rgba>
				endif
				if (<create_it>)
					CreateScreenElement {
						Type = SpriteElement
						parent = <myparent>
						id = <new_id>
						texture = <texture>
						Pos = <pos_off>
						rgba = <my_rgba>
						just = <just>
						z_priority = <zoff>
						alpha = <alpha>
						<flags>
						rot_angle = <rot>
						dims = <mydims>
						blend = <blend>
					}
				endif
				if StructureContains structure = <element_struct> Scale
					if (<create_it>)
						GetScreenElementDims id = <new_id>
						new_width = (<width> * <Scale>)
						new_height = (<height> * <Scale>)
						SetScreenElementProps id = <new_id> dims = (((1.0, 0.0) * <new_width>)+ ((0.0, 1.0) * <new_height>))
					endif
				endif
			endif
		endif
		if StructureContains structure = <element_struct> tube
			ExtendCrc <new_id> 'tube' out = new_child_id
			<zoff> = (<tube>.zoff)
			<alpha> = (<tube>.alpha)
			ExtendCrc <element_parent> <player_text> out = myparent
			if StructureContains structure = <element_struct> small_bulb
				scaled_dims = (<tube>.element_dims * (($g_hud_2d_struct_used).small_bulb_scale))
			else
				scaled_dims = (<tube>.element_dims * (($g_hud_2d_struct_used).big_bulb_scale))
			endif
			if ScreenElementExists id = <myparent>
				CreateScreenElement {
					Type = SpriteElement
					parent = <myparent>
					id = <new_child_id>
					texture = (<tube>.texture)
					Pos = (<pos_off> + (<tube>.pos_off))
					rgba = [0 240 250 255]
					blend = <blend>
					just = [center bottom]
					z_priority = <zoff>
					alpha = <alpha>
				}
				<parent> = <id>
				<new_child_id> ::SetTags morph = 0
				<new_child_id> ::SetTags old_dims = <element_dims>
				if StructureContains structure = <element_struct> initial_pos
					SetScreenElementProps id = <new_child_id> Pos = (<initial_pos> + (<tube>.pos_off))
					<new_child_id> ::SetTags {
						final_pos = (<pos_off> + (<tube>.pos_off))
						initial_pos = (<initial_pos> + (<tube>.pos_off))
						morph = 1
					}
				endif
			endif
		endif
		if StructureContains structure = <element_struct> full
			ExtendCrc <new_id> 'full' out = new_child_id
			<zoff> = (<full>.zoff)
			<alpha> = (<full>.alpha)
			ExtendCrc <element_parent> <player_text> out = myparent
			if StructureContains structure = <element_struct> small_bulb
				scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).small_bulb_scale))
			else
				scaled_dims = (<element_dims> * (($g_hud_2d_struct_used).big_bulb_scale))
			endif
			if ScreenElementExists id = <myparent>
				CreateScreenElement {
					Type = SpriteElement
					parent = <myparent>
					id = <new_child_id>
					texture = (<full>.texture)
					Pos = <pos_off>
					rgba = [255 255 255 255]
					blend = <blend>
					just = <just>
					z_priority = <zoff>
					alpha = <alpha>
				}
				<new_child_id> ::SetTags morph = 0
				if StructureContains structure = <element_struct> initial_pos
					SetScreenElementProps id = <new_child_id> Pos = <initial_pos>
					<new_child_id> ::SetTags final_pos = <pos_off>
					<new_child_id> ::SetTags initial_pos = <initial_pos>
					<new_child_id> ::SetTags morph = 1
				endif
			endif
		endif
		<i> = (<i> + 1)
	repeat <array_Size>
	if NOT ($game_mode = p2_battle || $boss_battle = 1)
		ExtendCrc HUD2D_Score_Text <player_text> out = new_id
		ExtendCrc HUD2D_score_container <player_text> out = new_score_container
		score_text_pos = (233.0, 73.0)
		if ($game_mode = p2_career || $game_mode = p2_coop)
			<score_text_pos> = (222.0, 85.0)
		endif
		if ScreenElementExists id = <new_score_container>
			displayText {
				parent = <new_score_container>
				id = <new_id>
				font = #"0xc0becb74"
				Pos = <score_text_pos>
				z = 20
				Scale = (1.1, 1.1)
				just = [right right]
				rgba = [255 255 255 255]
				noshadow
			}
			SetScreenElementProps id = <id> font_spacing = 3
		endif
		ExtendCrc HUD2D_Note_Streak_Text <player_text> out = new_id
		ExtendCrc HUD2D_note_container <player_text> out = new_note_container
		if ScreenElementExists id = <new_note_container>
			displayText {
				parent = <new_note_container>
				id = <new_id>
				font = #"0xc0becb74"
				text = '0'
				Pos = (176.0, 51.0)
				z = 25
				scale = 0.96
				just = [right center]
				rgba = [239 108 27 255]
				noshadow
			}
			SetScreenElementProps id = <new_id> font_spacing = 3
			<id> ::SetTags intial_pos = (210.0, 78.0)
		endif
	endif
endscript

script #"0xcf44f935"
	if ($game_mode = p2_career)
		<player_status> = player1_status
	endif
	FormatText textname = player_text 'p%d' d = ($<player_status>.Player)
	FormatText checksumName = player_spawned_scriptid 'player_spawned_scriptid_p%d' d = ($<player_status>.Player)
	spawnscriptnow {
		pulsate_all_star_power_bulbs params = {Player = ($<player_status>.Player)player_status = <player_status> player_text = <player_text>}
		id = <player_spawned_scriptid>
	}
	i = 1
	begin
		FormatText checksumName = id 'HUD2D_rock_tube_%d' d = <i>
		ExtendCrc <id> <player_text> out = parent_id
		if ScreenElementExists id = <parent_id>
			<parent_id> ::GetTags
			ExtendCrc <parent_id> 'tube' out = child_id
			<child_id> ::GetTags
			SetScreenElementProps id = <child_id> texture = (($g_hud_2d_struct_used).elements [<index>].tube.star_texture)
			ExtendCrc <parent_id> 'full' out = child_id
			<child_id> ::GetTags
			SetScreenElementProps id = <child_id> texture = (($g_hud_2d_struct_used).elements [<index>].full.star_texture)
		endif
		<i> = (<i> + 1)
	repeat 6
endscript

script pulsate_star_power_bulb
	if (ScreenElementExists id = <bulb_checksum>)
		ExtendCrc <bulb_checksum> 'tube' out = child_id
		SetScreenElementProps id = <child_id> alpha = 1.0
		ExtendCrc <bulb_checksum> 'full' out = child_id
		SetScreenElementProps id = <child_id> alpha = 1.0
	endif
endscript

script pulsate_big_glow
	ExtendCrc HUD2D_rock_glow <player_text> out = parent_id
	if NOT ScreenElementExists id = <parent_id>
		return
	endif
	begin
		if NOT ScreenElementExists id = <parent_id>
			return
		endif
		<parent_id> ::DoMorph alpha = 0 rgba = [95 205 255 255] time = 1 motion = ease_in
		if NOT ScreenElementExists id = <parent_id>
			return
		endif
		<parent_id> ::DoMorph alpha = 1 rgba = [255 255 255 255] time = 1 motion = ease_out
	repeat
endscript

script hud_flip_note_streak_num
endscript
battle_hud_2d_elements = {
	offscreen_rock_pos_p1 = (600.0, 1500.0)
	offscreen_rock_pos_p2 = (1374.0, 1500.0)
	rock_pos_p1 = (600.0, 625.0)
	card_1_off_p1 = (-92.0, -172.0)
	card_2_off_p1 = (-31.0, -36.0)
	card_3_off_p1 = (-49.0, -57.0)
	card_default_2_p1 = (37.0, -70.0)
	card_default_3_p1 = (12.0, -98.0)
	rock_pos_p2 = (1374.0, 625.0)
	card_1_off_p2 = (-286.0, -172.0)
	card_2_off_p2 = (-31.0, -36.0)
	card_3_off_p2 = (-49.0, -57.0)
	card_default_2_p2 = (37.0, -70.0)
	card_default_3_p2 = (12.0, -98.0)
	Scale = 0.75
	z = 0
	buttons_p2_offset = (510.0, 0.0)
	string_offset = (100.0, 0.0)
	green_button_pos = (185.0, 620.0)
	lefty_green_button_pos = (585.0, 620.0)
	attack_ready_text_pos_p1 = (-2000.0, 380.0)
	attack_ready_text_pos_p2 = (3000.0, 380.0)
	whammy_bottom_bar_pos_p1 = (640.0, 643.0)
	whammy_bottom_bar_pos_p2 = (635.0, 643.0)
	offscreen_gamertag_pos = (0.0, -400.0)
	final_gamertag_pos = (0.0, 0.0)
	#"0x936bb5fe" = $#"0x28381025"
	elements = [
		{
			parent_container
			element_id = #"0xa90fc148"
			pos_type = #"0x936bb5fe"
		}
		{
			element_id = #"0x99dd87cc"
			element_parent = #"0xa90fc148"
			texture = $#"0x1d52cdca"
			dims = $#"0x8d974f74"
			rot = -0.1
			just = [
				left
				top
			]
			rgba = $#"0x902ecc17"
			zoff = -2147483648
		}
		{
			parent_container
			element_id = HUD2D_rock_container
			pos_type = offscreen_rock_pos
		}
		{
			element_id = HUD2D_rock_body
			element_parent = HUD2D_rock_container
			texture = #"0x5bb47148"
			pos_off = (-70.0, -180.0)
			zoff = 20
			flags = {
				p1
			}
			rot = 0.0
		}
		{
			element_id = HUD2D_rock_BG_green
			element_parent = HUD2D_rock_container
			texture = #"0x450cea2a"
			pos_off = (-460.0, 21.0)
			zoff = 3
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_BG_red
			element_parent = HUD2D_rock_container
			texture = #"0x08c26d99"
			pos_off = (-460.0, 21.0)
			zoff = 3
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_BG_yellow
			element_parent = HUD2D_rock_container
			texture = #"0x95414c9e"
			pos_off = (-460.0, 21.0)
			zoff = 3
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_lights_all
			element_parent = HUD2D_rock_container
			texture = #"0x79a0865d"
			pos_off = (0.0, 0.0)
			zoff = 3
			Scale = 0.75
			rot = 5.0
		}
		{
			element_id = HUD2D_rock_lights_green
			element_parent = HUD2D_rock_container
			texture = #"0x89194192"
			pos_off = (-381.0, 9.0)
			zoff = 4
			just = [
				left
				top
			]
			blend = add
			alpha = 0
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_lights_red
			element_parent = HUD2D_rock_container
			texture = #"0xb8d9a80f"
			pos_off = (-422.0, 105.0)
			zoff = 4
			just = [
				left
				top
			]
			blend = add
			alpha = 0
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_lights_yellow
			element_parent = HUD2D_rock_container
			texture = #"0x5037628b"
			pos_off = (-351.0, 46.0)
			zoff = 4
			just = [
				center
				top
			]
			blend = add
			alpha = 0
			Scale = 0.75
			rot = -5.0
		}
		{
			element_id = HUD2D_rock_needle
			element_parent = HUD2D_rock_container
			texture = #"0x2438b25a"
			pos_off = (132.0, 1000.0)
			zoff = 18.5
			just = [
				0.5
				0.8
			]
		}
		{
			element_id = HUD2D_battle_default_icon2_1
			element_parent = HUD2D_rock_container
			texture = #"0x6f90ece8"
			zoff = 18.8999996
			pos_off = (39.0, -60.0)
			dims = (74.0, 74.0)
		}
		{
			element_id = HUD2D_battle_default_icon2_2
			element_parent = HUD2D_rock_container
			texture = #"0x6f90ece8"
			zoff = 18.8999996
			battle_pos
			pos_type = card_default_2
			dims = (48.0, 48.0)
			just = [
				center
				center
			]
		}
		{
			element_id = HUD2D_battle_default_icon2_3
			element_parent = HUD2D_rock_container
			texture = #"0x6f90ece8"
			zoff = 18.8999996
			battle_pos
			pos_type = card_default_3
			dims = (28.0, 28.0)
			just = [
				center
				center
			]
		}
	]
}
#"0xb8d68ee1" = 0.585
#"0xfbec6698" = (-558.0, 182.0)
#"0xf81f86d7" = (-458.0, 18.0)
#"0xfb0d3c99" = 1.0
#"0x2ce68ed8" = 0.8
#"0xb6ac2f81" = [
	60
	255
	60
	255
]
#"0xdcf09d3c" = [
	255
	255
	48
	255
]
#"0x8fb6f5f6" = [
	255
	71
	68
	255
]
#"0x4ca1aa8d" = [
	175
	175
	175
	255
]
#"0xb9828f7c" = 256.0
#"0xd5189206" = 6.5
#"0xd22c1054" = 267.0
#"0xe0c69463" = 6.0
#"0x9b53cde3" = (-6.0, 35.0)
#"0x1d41c861" = (-3.0, 91.0)
SP_Fill_color_0 = [
	255
	255
	255
	255
]
career_hud_2d_elements = {
	offscreen_rock_pos = (450.0, -1000.0)
	offscreen_score_pos = (1368.0, 1500.0)
	rock_pos = (450.0, 692.0)
	score_pos = (1368.0, 768.0)
	counter_pos = (1397.0, 828.7)
	offscreen_rock_pos_p1 = (100.0, -1000.0)
	offscreen_score_pos_p1 = (180.0, -200.0)
	rock_pos_p1 = (100.0, 692.0)
	score_pos_p1 = (180.0, 80.0)
	counter_pos_p1 = (-2000.0, 200.0)
	offscreen_rock_pos_p2 = (900.0, -1000.0)
	offscreen_score_pos_p2 = (1368.0, -200.0)
	rock_pos_p2 = (900.0, 692.0)
	score_pos_p2 = (1368.0, 80.0)
	counter_pos_p2 = (-2000.0, 200.0)
	offscreen_note_streak_bar_off = (0.0, 800.0)
	Scale = 0.7
	small_bulb_scale = 0.7
	big_bulb_scale = 0.8
	z = 0
	score_frame_width = 175.0
	offscreen_gamertag_pos = (0.0, -400.0)
	final_gamertag_pos = (0.0, 0.0)
	#"0x936bb5fe" = $#"0x28381025"
	elements = [
		{
			parent_container
			element_id = #"0xa90fc148"
			pos_type = #"0x936bb5fe"
		}
		{
			element_id = #"0x99dd87cc"
			element_parent = #"0xa90fc148"
			texture = $#"0x1d52cdca"
			dims = $#"0x8d974f74"
			rot = -0.1
			just = [
				left
				top
			]
			rgba = $#"0x902ecc17"
			zoff = -2147483648
		}
		{
			parent_container
			element_id = HUD2D_rock_container
			pos_type = offscreen_rock_pos
		}
		{
			element_id = HUD2D_rock_glow
			element_parent = HUD2D_rock_container
			texture = none
			pos_off = (650.0, -70.0)
			dims = (350.0, 350.0)
			rgba = [
				95
				205
				255
				255
			]
			alpha = 0
			zoff = -20
		}
		{
			element_id = HUD2D_rock_body
			element_parent = HUD2D_rock_container
			texture = #"0xffdc02c4"
			pos_off = (643.0, -56.0)
			zoff = 3.2
		}
		{
			element_id = HUD2D_rock_BG_green
			element_parent = HUD2D_rock_body
			texture = #"0x450cea2a"
			pos_off = (-615.0, 6.0)
			zoff = 3.2
		}
		{
			element_id = HUD2D_rock_BG_red
			element_parent = HUD2D_rock_body
			texture = #"0x08c26d99"
			pos_off = (-615.0, 6.0)
			zoff = 3.0
		}
		{
			element_id = HUD2D_rock_BG_yellow
			element_parent = HUD2D_rock_body
			texture = #"0x95414c9e"
			pos_off = (-615.0, 6.0)
			zoff = 3.0999999
		}
		{
			element_id = HUD2D_rock_lights_all
			element_parent = HUD2D_rock_body
			texture = #"0x79a0865d"
			pos_off = (0.0, 0.0)
			zoff = 3
		}
		{
			element_id = HUD2D_rock_lights_green
			element_parent = HUD2D_rock_body
			texture = #"0x89194192"
			pos_off = (-509.0, 0.0)
			zoff = 18
			just = [
				left
				top
			]
			blend = add
			alpha = 0
		}
		{
			element_id = HUD2D_rock_lights_red
			element_parent = HUD2D_rock_body
			texture = #"0xb8d9a80f"
			pos_off = (-574.0, 120.0)
			zoff = 7
			just = [
				left
				top
			]
			blend = add
			alpha = 0
		}
		{
			element_id = HUD2D_rock_lights_yellow
			element_parent = HUD2D_rock_body
			texture = #"0x5037628b"
			pos_off = (-474.0, 52.0)
			zoff = 18
			just = [
				center
				top
			]
			blend = add
			alpha = 0
		}
		{
			element_id = HUD2D_rock_needle
			element_parent = HUD2D_rock_body
			texture = #"0x2438b25a"
			alpha = 0.0
			pos_off = (900.0, -900.0)
			zoff = 19
			just = [
				0.5
				0.8
			]
		}
		{
			element_id = #"0xcccf93ce"
			element_parent = HUD2D_rock_body
			texture = #"0x2438b25a"
			pos_off = (-450.0, 120.0)
			zoff = 20
		}
		{
			element_id = #"0x42b328e7"
			element_parent = #"0xcccf93ce"
			texture = #"0xa94dd223"
			pos_off = (0.0, 0.0)
			zoff = 19
			blend = add
		}
		{
			element_id = #"0xf6fb9573"
			element_parent = #"0xcccf93ce"
			texture = HUD_tubeglow2
			pos_off = (0.0, 0.0)
			zoff = 19
			blend = add
			alpha = 0.2
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_1
			element_parent = HUD2D_rock_container
			pos_off = (880.6500244140625, 294.5)
			rot = -27.0
		}
		{
			element_id = HUD2D_rock_tube_1
			element_parent = HUD2D_bulb_container_1
			texture = None
			#"0xe9cd1dc2" = (-14.0, -171.0)
			pos_off = (2.0, -170.0)
			element_dims = (64.0, 128.0)
			big_bulb
			rgba = [
				0
				170
				136
				255
			]
			blend = add
			zoff = 0
			just = [
			]
			container
			tube = {
				texture = #"0x826d0fd3"
				star_texture = #"0x826d0fd3"
				pos_off = (0.0, 30.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			element_id = #"0x60199acb"
			element_parent = HUD2D_bulb_container_1
			texture = #"0x9715a455"
			pos_off = (-11.0, -192.0)
			rot = 30.0
			zoff = 30
			rgba = [
				0
				240
				255
				255
			]
			blend = add
		}
		{
			parent_container
			element_id = #"0x9ef74ba0"
			element_parent = HUD2D_rock_container
			pos_off = (814.7000122070312, 162.0)
			rot = -27
		}
		{
			element_id = HUD2D_SP_glow_end
			element_parent = #"0x9ef74ba0"
			texture = #"0x9715a455"
			pos_off = (-5.0, -200.0)
			rot = 30.0
			Scale = 1.0
			just = [
				center
				center
			]
			zoff = 30
			rgba = [
				255
				255
				255
				255
			]
			blend = add
		}
		{
			element_id = HUD2D_SP_glow_end2
			element_parent = HUD2D_SP_glow_end
			texture = #"0x9715a455"
			pos_off = (32.0, 32.0)
			rot = 0.0
			Scale = 1.0
			just = [
				center
				center
			]
			zoff = 30
			rgba = [
				0
				164
				200
				255
			]
			blend = add
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_2
			element_parent = HUD2D_rock_container
			pos_off = (851.5, 240.0)
			rot = -27
		}
		{
			element_id = HUD2D_rock_tube_2
			element_parent = HUD2D_bulb_container_2
			texture = None
			pos_off = (3.0, -152.1999969482422)
			element_dims = (64.0, 128.0)
			big_bulb
			rgba = [
				0
				170
				136
				255
			]
			blend = add
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x04f97d7d"
				star_texture = #"0x04f97d7d"
				pos_off = (0.0, 37.5)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_3
			element_parent = HUD2D_rock_container
			pos_off = (839.0, 208.5)
			rot = -27.0
		}
		{
			element_id = HUD2D_rock_tube_3
			element_parent = HUD2D_bulb_container_3
			texture = None
			pos_off = (0.0, -150.0)
			element_dims = (64.0, 128.0)
			big_bulb
			rgba = [
				0
				170
				136
				255
			]
			blend = add
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0xcfa5aed8"
				star_texture = #"0xcfa5aed8"
				element_dims = (755.0, 100.0)
				pos_off = (0.0, 28.700000762939453)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_4
			element_parent = HUD2D_rock_container
			pos_off = (817.0, 181.0)
			rot = -27
		}
		{
			element_id = HUD2D_rock_tube_4
			element_parent = HUD2D_bulb_container_4
			texture = None
			pos_off = (0.0, -150.0)
			element_dims = (64.0, 128.0)
			big_bulb
			rgba = [
				0
				170
				136
				255
			]
			blend = add
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x826d0fd3"
				star_texture = #"0x826d0fd3"
				element_dims = (755.0, 100.0)
				pos_off = (1.0, 31.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_5
			element_parent = HUD2D_rock_container
			pos_off = (730.0, 21.0)
			'why even'
			rot = -27
		}
		{
			element_id = HUD2D_rock_tube_5
			element_parent = HUD2D_bulb_container_5
			texture = None
			pos_off = (0.0, -120.0)
			initial_pos = (0.0, 0.0)
			element_dims = (64.0, 128.0)
			big_bulb
			blend = add
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x9816c0d3"
				star_texture = #"0x9816c0d3"
				pos_off = (6.0, 146.8000030517578)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 1
			}
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_6
			element_parent = HUD2D_rock_container
			pos_off = (710.0, -17.0)
			rot = -27
		}
		{
			element_id = HUD2D_rock_tube_6
			element_parent = HUD2D_bulb_container_6
			texture = None
			pos_off = (-2.0, 0.10000000149011612)
			initial_pos = (0.0, 0.0)
			element_dims = (64.0, 128.0)
			big_bulb
			blend = add
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x3e61cb67"
				star_texture = #"0x3e61cb67"
				element_dims = (64.0, 16.0)
				pos_off = (8.0, 31.399999618530273)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = None
				star_texture = None
				zoff = 8.1999998
				alpha = 1
			}
		}
		{
			parent_container
			element_id = HUD2D_score_container
			pos_type = offscreen_score_pos
		}
		{
			element_id = HUD2D_score_body
			element_parent = HUD2D_score_container
			texture = #"0xe4334497"
			pos_type = score_pos
			pos_off = (-30.0, -9.0)
			zoff = 5
		}
		{
			parent_container
			element_id = HUD2D_note_container
			pos_type = counter_pos
			note_streak_bar
			pos_off = (0.0, 0.0)
		}
		{
			element_id = HUD2D_counter_body
			element_parent = HUD2D_note_container
			texture = #"0x38b63489"
			pos_off = (0.0, 0.0)
			scale = 0.78
			zoff = 4
		}
		{
			element_id = #"0x4020ac1b"
			element_parent = HUD2D_note_container
			texture = #"0x4020ac1b"
			pos_off = (4.0, 40.0)
			zoff = 8
		}
		{
			element_id = HUD2D_counter_drum_icon
			element_parent = HUD2D_note_container
			texture = None
			pos_off = (44.0, 40.0)
			zoff = 26
		}
		{
			element_id = HUD2D_score_light_unlit_1
			element_parent = HUD2D_score_container
			texture = #"0xb2f82657"
			pos_off = (-235.0, -165.0)
			zoff = 5
		}
		{
			element_id = HUD2D_score_light_unlit_2
			element_parent = HUD2D_score_container
			texture = #"0xb2f82657"
			pos_off = (-245.0, -182.0)
			zoff = 5
		}
		{
			element_id = HUD2D_score_light_unlit_3
			element_parent = HUD2D_score_container
			texture = #"0xb2f82657"
			pos_off = (-255.0, -199.0)
			zoff = 5
		}
		{
			element_id = HUD2D_score_light_unlit_4
			element_parent = HUD2D_score_container
			texture = #"0xb2f82657"
			pos_off = (-265.0, -216.0)
			zoff = 5
		}
		{
			element_id = HUD2D_score_light_unlit_5
			element_parent = HUD2D_score_container
			texture = #"0xb2f82657"
			pos_off = (-275.0, -233.0)
			zoff = 5
		}
		{
			element_id = HUD2D_score_light_halflit_1
			element_parent = HUD2D_score_container
			texture = #"0xc5ff16c1"
			pos_off = (-235.0, -165.0)
			zoff = 5.0999999
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_halflit_2
			element_parent = HUD2D_score_container
			texture = #"0xc5ff16c1"
			pos_off = (-245.0, -182.0)
			zoff = 5.0999999
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_halflit_3
			element_parent = HUD2D_score_container
			texture = #"0xc5ff16c1"
			pos_off = (-255.0, -199.0)
			zoff = 5.0999999
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_halflit_4
			element_parent = HUD2D_score_container
			texture = #"0xc5ff16c1"
			pos_off = (-265.0, -216.0)
			zoff = 5.0999999
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_halflit_5
			element_parent = HUD2D_score_container
			texture = #"0xc5ff16c1"
			pos_off = (-275.0, -233.0)
			zoff = 5.0999999
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_allwaylit_1
			element_parent = HUD2D_score_container
			texture = #"0x5cf6477b"
			pos_off = (-235.0, -165.0)
			zoff = 5.1999998
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_allwaylit_2
			element_parent = HUD2D_score_container
			texture = #"0x5cf6477b"
			pos_off = (-245.0, -182.0)
			zoff = 5.1999998
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_allwaylit_3
			element_parent = HUD2D_score_container
			texture = #"0x5cf6477b"
			pos_off = (-255.0, -199.0)
			zoff = 5.1999998
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_allwaylit_4
			element_parent = HUD2D_score_container
			texture = #"0x5cf6477b"
			pos_off = (-265.0, -216.0)
			zoff = 5.1999998
			alpha = 0
		}
		{
			element_id = HUD2D_score_light_allwaylit_5
			element_parent = HUD2D_score_container
			texture = #"0x5cf6477b"
			pos_off = (-275.0, -233.0)
			zoff = 5.1999998
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_1a
			element_parent = HUD2D_score_container
			texture = #"0xb373f287"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_2a
			element_parent = HUD2D_score_container
			texture = #"0x985ea144"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_2b
			element_parent = HUD2D_score_container
			texture = #"0x0157f0fe"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_3a
			element_parent = HUD2D_score_container
			texture = #"0x81459005"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_4a
			element_parent = HUD2D_score_container
			texture = #"0xce0406c2"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_4b
			element_parent = HUD2D_score_container
			texture = #"0x570d5778"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_6b
			element_parent = HUD2D_score_container
			texture = #"0x653b35fa"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_8b
			element_parent = HUD2D_score_container
			texture = #"0xfbb81874"
			pos_off = (-278.0, -230.0)
			zoff = 1
			alpha = 0
		}
		{
			element_id = HUD2D_score_flash
			element_parent = HUD2D_score_container
			texture = #"0x36f7ff86"
			just = [
				center
				center
			]
			pos_off = (128.0, 128.0)
			zoff = 20
			alpha = 0
		}
		{
			element_id = #"0x0500c035"
			element_parent = HUD2D_score_container
			texture = white
			just = [
				left
				center
			]
			pos_off = (-12.0, 84.0)
			dims = (256.0, 6.0)
			zoff = 28
			alpha = 1
			rgba = [
				196
				169
				65
				255
			]
		}
		{
			element_id = #"0xddc6125f"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_line
			just = [
				left
				center
			]
			pos_off = (-13.0, 89.0)
			dims = (256.0, 12.0)
			zoff = 3
			Scale = 1.7
		}
		{
			element_id = #"0x4ae39f0b"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_cursor
			just = [
				0.7
				0.5
			]
			zoff = 29
			blend = add
			Scale = 0.9
		}
		{
			element_id = #"0x95a37ec5"
			element_parent = HUD2D_score_container
			texture = white
			just = [
				left
				center
			]
			pos_off = (-17.0, 28.0)
			dims = (267.0, 6.0)
			zoff = 4
			alpha = 1
			rgba = [
				70
				125
				196
				255
			]
		}
		{
			element_id = #"0x3693c461"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_line
			just = [
				left
				center
			]
			pos_off = (-17.0, 33.0)
			dims = (267.0, 12.0)
			zoff = 3
			Scale = 1.65
		}
		{
			element_id = #"0x766026d8"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_cursor
			just = [
				0.7
				0.5
			]
			zoff = 6
			blend = add
			Scale = 0.9
		}
		{
			parent_container
			element_id = #"0xf1b083bb"
			element_parent = HUD2D_score_container
			pos_off = (220.0, 15.0)
		}
		{
			element_id = #"0xad82033a"
			element_parent = #"0xf1b083bb"
			texture = #"0x65aaa809"
			alpha = 1
			zoff = 20
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0xda8533ac"
			element_parent = #"0xf1b083bb"
			texture = #"0x12ad989f"
			alpha = 0
			zoff = 21
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0x438c6216"
			element_parent = #"0xf1b083bb"
			texture = #"0x8ba4c925"
			alpha = 0
			zoff = 22
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0x348b5280"
			element_parent = #"0xf1b083bb"
			texture = #"0xfca3f9b3"
			alpha = 0
			zoff = 23
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0xaaefc723"
			element_parent = #"0xf1b083bb"
			texture = #"0x62c76c10"
			alpha = 0
			zoff = 24
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0xdde8f7b5"
			element_parent = #"0xf1b083bb"
			texture = #"0x15c05c86"
			alpha = 0
			zoff = 25
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = HUD2D_score_star_6
			element_parent = #"0xf1b083bb"
			texture = WOR_score_star_6
			alpha = 0
			zoff = 26
			pos_off = (-20.0, -28.0)
			Scale = 1.4
		}
		{
			element_id = #"0x3a74478c"
			element_parent = #"0xf1b083bb"
			texture = WOR_score_FC_glow
			alpha = 1
			zoff = 27
			blend = add
			pos_off = (-4.0, -11.0)
			Scale = 1.1
		}
	]
}
coop_career_hud_2d_elements = {
	offscreen_rock_pos = (730.0, -440.0)
	offscreen_score_pos = (730.0, -3000.0)
	rock_pos = (730.0, 440.0)
	score_pos = (1600.0, 262.0)
	counter_pos = (1600.0, 330.0)
	offscreen_note_streak_bar_off = (0.0, -600.0)
	Scale = 0.6
	small_bulb_scale = 0.7
	big_bulb_scale = 1.0
	z = 0
	score_frame_width = 200.0
	offscreen_gamertag_pos = (0.0, -400.0)
	final_gamertag_pos = (0.0, 0.0)
	#"0x936bb5fe" = $#"0x28381025"
	elements = [
		{
			parent_container
			element_id = #"0xa90fc148"
			pos_type = #"0x936bb5fe"
		}
		{
			element_id = #"0x99dd87cc"
			element_parent = #"0xa90fc148"
			texture = $#"0x1d52cdca"
			dims = $#"0x8d974f74"
			rot = -0.1
			just = [
				left
				top
			]
			rgba = $#"0x902ecc17"
			zoff = -2147483648
		}
		{
			parent_container
			element_id = HUD2D_rock_container
			pos_type = offscreen_rock_pos
		}
		{
			element_id = HUD2D_2p_c_rock_shadow
			element_parent = HUD2D_rock_container
			texture = #"0xe70e0762"
			pos_off = (0.0, 0.0)
			zoff = -1
			create_once
		}
		{
			element_id = HUD2D_rock_body
			element_parent = HUD2D_rock_container
			texture = #"0xbfd3fab3"
			Scale = 1.75
			pos_off = (-623.0, -447.0)
			zoff = 5
			create_once
		}
		{
			element_id = HUD2D_rock_lights_all
			element_parent = HUD2D_rock_body
			texture = #"0x3f3a3d2e"
			pos_off = (0.0, 0.0)
			zoff = 1
			create_once
		}
		{
			element_id = HUD2D_rock_lights_green
			element_parent = HUD2D_rock_body
			texture = #"0x0b633510"
			pos_off = (6.0, 118.0)
			zoff = 2
			just = [
				left
				top
			]
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_rock_lights_red
			element_parent = HUD2D_rock_body
			texture = #"0x3ffd7bc9"
			pos_off = (6.0, 118.0)
			zoff = 2
			just = [
				left
				top
			]
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_rock_lights_yellow
			element_parent = HUD2D_rock_body
			texture = #"0x5303faf3"
			pos_off = (134.0, 118.0)
			zoff = 2
			just = [
				center
				top
			]
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_rock_needle
			element_parent = HUD2D_rock_body
			texture = #"0x1d10dde9"
			pos_off = (140.0, 235.0)
			zoff = 3
			just = [
				0.5
				0.6
			]
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_1
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = -60.0
			create_once
		}
		{
			element_id = HUD2D_rock_tube_1
			element_parent = HUD2D_bulb_container_1
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			element_dims = (64.0, 128.0)
			rgba = [
				255
				255
				255
				255
			]
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 0
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_2
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = -40
			create_once
		}
		{
			element_id = HUD2D_rock_tube_2
			element_parent = HUD2D_bulb_container_2
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			element_dims = (64.0, 128.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 0
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_3
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = -20.0
			create_once
		}
		{
			element_id = HUD2D_rock_tube_3
			element_parent = HUD2D_bulb_container_3
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			element_dims = (64.0, 128.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 0
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_4
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = 0
			create_once
		}
		{
			element_id = HUD2D_rock_tube_4
			element_parent = HUD2D_bulb_container_4
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			initial_pos = (0.0, 0.0)
			element_dims = (64.0, 128.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 1
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_5
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = 21
			create_once
		}
		{
			element_id = HUD2D_rock_tube_5
			element_parent = HUD2D_bulb_container_5
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			initial_pos = (0.0, 0.0)
			element_dims = (64.0, 128.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 1
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_bulb_container_6
			element_parent = HUD2D_rock_container
			pos_off = (-387.0, -47.0)
			rot = 42
			create_once
		}
		{
			element_id = HUD2D_rock_tube_6
			element_parent = HUD2D_bulb_container_6
			texture = #"0xd944d7e8"
			pos_off = (0.0, -170.0)
			initial_pos = (0.0, 0.0)
			element_dims = (64.0, 128.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 0.1
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 0.2
				alpha = 1
			}
			create_once
		}
		{
			parent_container
			element_id = HUD2D_score_container
			pos_type = offscreen_score_pos
			create_once
		}
		{
			element_id = HUD2D_score_body
			element_parent = HUD2D_score_container
			texture = #"0x2a12aff0"
			pos_off = (-25.0, 7.0)
			zoff = 19
			create_once
		}
		{
			parent_container
			element_id = HUD2D_light_container_1
			element_parent = HUD2D_rock_container
			pos_off = (167.0, 358.3999938964844)
			rot = 270
			create_once
		}
		{
			element_id = HUD2D_score_light_unlit_1
			element_parent = HUD2D_light_container_1
			texture = #"0xb2f82657"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 4
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			parent_container
			element_id = HUD2D_light_container_2
			element_parent = HUD2D_rock_container
			pos_off = (157.0, 341.3999938964844)
			rot = 270
			create_once
		}
		{
			element_id = HUD2D_score_light_unlit_2
			element_parent = HUD2D_light_container_2
			texture = #"0xb2f82657"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 4
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			parent_container
			element_id = HUD2D_light_container_3
			element_parent = HUD2D_rock_container
			pos_off = (147.0, 324.3999938964844)
			rot = 270
			create_once
		}
		{
			element_id = HUD2D_score_light_unlit_3
			element_parent = HUD2D_light_container_3
			texture = #"0xb2f82657"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 4
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			parent_container
			element_id = HUD2D_light_container_4
			element_parent = HUD2D_rock_container
			pos_off = (137.0, 307.3999938964844)
			rot = 270
			create_once
		}
		{
			element_id = HUD2D_score_light_unlit_4
			element_parent = HUD2D_light_container_4
			texture = #"0xb2f82657"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 4
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			parent_container
			element_id = HUD2D_light_container_5
			element_parent = HUD2D_rock_container
			pos_off = (127.0, 290.3999938964844)
			rot = 270
			create_once
		}
		{
			element_id = HUD2D_score_light_unlit_5
			element_parent = HUD2D_light_container_5
			texture = #"0xb2f82657"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 4
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_halflit_1
			element_parent = HUD2D_light_container_1
			texture = #"0xc5ff16c1"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 5
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_halflit_2
			element_parent = HUD2D_light_container_2
			texture = #"0xc5ff16c1"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 5
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_halflit_3
			element_parent = HUD2D_light_container_3
			texture = #"0xc5ff16c1"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 5
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_halflit_4
			element_parent = HUD2D_light_container_4
			texture = #"0xc5ff16c1"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 5
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_halflit_5
			element_parent = HUD2D_light_container_5
			texture = #"0xc5ff16c1"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 5
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_allwaylit_1
			element_parent = HUD2D_light_container_1
			texture = #"0x5cf6477b"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 6
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_allwaylit_2
			element_parent = HUD2D_light_container_2
			texture = #"0x5cf6477b"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 6
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_allwaylit_3
			element_parent = HUD2D_light_container_3
			texture = #"0x5cf6477b"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 6
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_allwaylit_4
			element_parent = HUD2D_light_container_4
			texture = #"0x5cf6477b"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 6
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_light_allwaylit_5
			element_parent = HUD2D_light_container_5
			texture = #"0x5cf6477b"
			pos_off = (0.0, -80.0)
			element_dims = (32.0, 32.0)
			zoff = 6
			rot = 90
			just = [
				center
				center
			]
			create_once
			flags = {
				p1
			}
		}
		{
			element_id = HUD2D_score_nixie_1a
			element_parent = HUD2D_rock_container
			texture = #"0xb373f287"
			pos_type = score_pos
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_2a
			element_parent = HUD2D_rock_container
			texture = #"0x985ea144"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_2b
			element_parent = HUD2D_rock_container
			texture = #"0x0157f0fe"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_3a
			element_parent = HUD2D_rock_container
			texture = #"0x81459005"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_4a
			element_parent = HUD2D_rock_container
			texture = #"0xce0406c2"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_4b
			element_parent = HUD2D_rock_container
			texture = #"0x570d5778"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_6b
			element_parent = HUD2D_rock_container
			texture = #"0x653b35fa"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_nixie_8b
			element_parent = HUD2D_rock_container
			texture = #"0xfbb81874"
			pos_off = (30.0, 280.0)
			Scale = 0.9
			zoff = 4
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_score_flash
			element_parent = HUD2D_rock_container
			texture = #"0x36f7ff86"
			just = [
				center
				center
			]
			pos_off = (128.0, 128.0)
			zoff = 20
			alpha = 0
			create_once
		}
		{
			parent_container
			element_id = HUD2D_note_container
			pos_type = counter_pos
			note_streak_bar
			pos_off = (0.0, 0.0)
			create_once
		}
		{
			element_id = HUD2D_counter_body
			element_parent = HUD2D_note_container
			texture = #"0x38b63489"
			pos_off = (0.0, 0.0)
			zoff = 18
			create_once
		}
		{
			element_id = #"0x4020ac1b"
			element_parent = HUD2D_note_container
			texture = #"0x4020ac1b"
			pos_off = (4.0, 40.0)
			zoff = 21
			create_once
		}
		{
			element_id = HUD2D_counter_drum_icon
			element_parent = HUD2D_note_container
			texture = None
			pos_off = (44.0, 40.0)
			zoff = 26
			create_once
		}
	]
}
faceoff_hud_2d_elements = {
	offscreen_rock_pos = (1024.0, 1500.0)
	offscreen_score_pos_p1 = (560.0, -1000.0)
	rock_pos = (1024.0, 620.0)
	score_pos_p1 = (560.0, 480.0)
	counter_pos_p1 = (565.0, 533.0)
	offscreen_score_pos_p2 = (1720.0, -1000.0)
	score_pos_p2 = (1720.0, 480.0)
	counter_pos_p2 = (1720.0, 533.0)
	offscreen_note_streak_bar_off_p1 = (-1000.0, 0.0)
	offscreen_note_streak_bar_off_p2 = (1000.0, 0.0)
	use_note_streak_morph_pos = 1
	offscreen_gamertag_pos = (0.0, -400.0)
	final_gamertag_pos = (0.0, 0.0)
	Scale = 0.5
	small_bulb_scale = 0.6
	big_bulb_scale = 0.6
	z = 0
	score_frame_width = 175.0
	#"0x936bb5fe" = $#"0x28381025"
	elements = [
		{
			parent_container
			element_id = #"0xa90fc148"
			pos_type = #"0x936bb5fe"
		}
		{
			element_id = #"0x99dd87cc"
			element_parent = #"0xa90fc148"
			texture = $#"0x1d52cdca"
			dims = $#"0x8d974f74"
			rot = -0.1
			just = [
				left
				top
			]
			rgba = $#"0x902ecc17"
			zoff = -2147483648
		}
		{
			parent_container
			element_id = HUD2D_rock_container
			pos_type = offscreen_rock_pos
			create_once
		}
		{
			element_id = HUD2D_rock_body
			element_parent = HUD2D_rock_container
			texture = #"0x10999827"
			pos_off = (-130.0, 320.0)
			zoff = 3.2
			Scale = 1.0
			create_once
		}
		{
			element_id = HUD2D_rock_BG_p1
			element_parent = HUD2D_rock_body
			texture = #"0x3f41a821"
			pos_off = (-560.0, -60.0)
			zoff = 21
			alpha = 0
			Scale = 2.0
			create_once
		}
		{
			element_id = HUD2D_rock_BG_p2
			element_parent = HUD2D_rock_body
			texture = #"0xa648f99b"
			pos_off = (-560.0, -60.0)
			zoff = 21
			alpha = 0
			Scale = 2.0
			create_once
		}
		{
			element_id = HUD2D_rock_BG_off
			element_parent = HUD2D_rock_body
			texture = #"0x0a07ba45"
			pos_off = (0.0, 0.0)
			zoff = 3
			create_once
		}
		{
			element_id = HUD2D_rock_needle
			element_parent = HUD2D_rock_body
			texture = #"0x2438b25a"
			pos_off = (132.0, 1000.0)
			zoff = 19
			just = [
				0.5
				0.75
			]
			dims = (16.0, 100.0)
			create_once
		}
		{
			element_id = HUD2D_rock_crystal_p1
			element_parent = HUD2D_rock_body
			texture = #"0xc9aa7a01"
			pos_off = (64.0, 64.0)
			zoff = 21
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_rock_crystal_p2
			element_parent = HUD2D_rock_body
			texture = #"0x50a32bbb"
			pos_off = (64.0, 64.0)
			zoff = 21
			alpha = 0
			create_once
		}
		{
			element_id = HUD2D_rock_crystal_off
			element_parent = HUD2D_rock_body
			texture = #"0x319f715f"
			pos_off = (-50.0, -110.0)
			zoff = 14
			create_once
		}
		{
			parent_container
			element_id = HUD2D_score_container
			pos_type = offscreen_score_pos
		}
		{
			element_id = HUD2D_score_body
			element_parent = HUD2D_score_container
			texture = #"0xe4334497"
			pos_type = score_pos
			pos_off = (-25.0, -7.0)
			zoff = 5
		}
		{
			parent_container
			element_id = HUD2D_bulb_container
			element_parent = HUD2D_score_container
			pos_off = (-33.0, 0.0)
			rot = -20
			rot_p2 = -20
		}
		{
			element_id = HUD2D_rock_tube_1
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (260.0, 790.0)
			pos_off_p2 = (257.0, 790.0)
			element_dims = (64.0, 100.0)
			small_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			element_id = HUD2D_rock_tube_2
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (258.0, 759.0)
			pos_off_p2 = (255.0, 759.0)
			element_dims = (64.0, 100.0)
			small_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			element_id = HUD2D_rock_tube_3
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (256.0, 728.0)
			pos_off_p2 = (253.0, 728.0)
			element_dims = (64.0, 100.0)
			small_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 40.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 0
			}
		}
		{
			element_id = HUD2D_rock_tube_4
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (252.0, 694.0)
			initial_pos = (252.0, 694.0)
			pos_off_p2 = (236.0, 696.0)
			initial_pos_p2 = (236.0, 696.0)
			element_dims = (64.0, 100.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 1
			}
		}
		{
			element_id = HUD2D_rock_tube_5
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (249.0, 660.0)
			initial_pos = (249.0, 660.0)
			pos_off_p2 = (230.0, 666.0)
			initial_pos_p2 = (230.0, 666.0)
			element_dims = (64.0, 100.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 1
			}
		}
		{
			element_id = HUD2D_rock_tube_6
			element_parent = HUD2D_bulb_container
			texture = #"0xd944d7e8"
			pos_off = (246.0, 634.0)
			initial_pos = (246.0, 634.0)
			pos_off_p2 = (230.0, 638.0)
			initial_pos_p2 = (230.0, 638.0)
			element_dims = (64.0, 100.0)
			big_bulb
			zoff = 0
			just = [
				center
				center
			]
			container
			tube = {
				texture = #"0x351b676f"
				star_texture = #"0xaf2cf767"
				element_dims = (64.0, 16.0)
				pos_off = (0.0, 32.0)
				zoff = 3.0999999
				alpha = 1
			}
			full = {
				texture = #"0x20273d7b"
				star_texture = #"0x0a3c8de4"
				zoff = 8.1999998
				alpha = 1
			}
		}
		{
			parent_container
			element_id = HUD2D_score_lights_container
			element_parent = HUD2D_score_container
			pos_off = (-21.0, 6.0)
			rot = 0
			rot_p2 = 0
		}
		{
			element_id = HUD2D_score_light_unlit_1
			element_parent = HUD2D_score_lights_container
			texture = #"0xb2f82657"
			pos_type = score_pos
			pos_off = (410.0, 422.0)
			pos_off_p2 = (410.0, 422.0)
			zoff = 15
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_unlit_2
			element_parent = HUD2D_score_lights_container
			texture = #"0xb2f82657"
			pos_type = score_pos
			pos_off = (398.0, 402.0)
			pos_off_p2 = (398.0, 402.0)
			zoff = 15
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_unlit_3
			element_parent = HUD2D_score_lights_container
			texture = #"0xb2f82657"
			pos_type = score_pos
			pos_off = (386.0, 382.0)
			pos_off_p2 = (386.0, 382.0)
			zoff = 15
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_unlit_4
			element_parent = HUD2D_score_lights_container
			texture = #"0xb2f82657"
			pos_type = score_pos
			pos_off = (374.0, 362.0)
			pos_off_p2 = (374.0, 362.0)
			zoff = 15
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_unlit_5
			element_parent = HUD2D_score_lights_container
			texture = #"0xb2f82657"
			pos_type = score_pos
			pos_off = (362.0, 342.0)
			pos_off_p2 = (362.0, 342.0)
			zoff = 15
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_halflit_1
			element_parent = HUD2D_score_lights_container
			texture = #"0xc5ff16c1"
			pos_type = score_pos
			pos_off = (410.0, 422.0)
			pos_off_p2 = (410.0, 422.0)
			zoff = 15.1000004
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_halflit_2
			element_parent = HUD2D_score_lights_container
			texture = #"0xc5ff16c1"
			pos_type = score_pos
			pos_off = (398.0, 402.0)
			pos_off_p2 = (398.0, 402.0)
			zoff = 15.1000004
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_halflit_3
			element_parent = HUD2D_score_lights_container
			texture = #"0xc5ff16c1"
			pos_type = score_pos
			pos_off = (386.0, 382.0)
			pos_off_p2 = (386.0, 382.0)
			zoff = 15.1000004
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_halflit_4
			element_parent = HUD2D_score_lights_container
			texture = #"0xc5ff16c1"
			pos_type = score_pos
			pos_off = (374.0, 362.0)
			pos_off_p2 = (374.0, 362.0)
			zoff = 15.1000004
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_halflit_5
			element_parent = HUD2D_score_lights_container
			texture = #"0xc5ff16c1"
			pos_type = score_pos
			pos_off = (362.0, 342.0)
			pos_off_p2 = (362.0, 342.0)
			zoff = 15.1000004
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_allwaylit_1
			element_parent = HUD2D_score_lights_container
			texture = #"0x5cf6477b"
			pos_type = score_pos
			pos_off = (410.0, 422.0)
			pos_off_p2 = (410.0, 422.0)
			zoff = 15.1999998
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_allwaylit_2
			element_parent = HUD2D_score_lights_container
			texture = #"0x5cf6477b"
			pos_type = score_pos
			pos_off = (398.0, 402.0)
			pos_off_p2 = (398.0, 402.0)
			zoff = 15.1999998
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_allwaylit_3
			element_parent = HUD2D_score_lights_container
			texture = #"0x5cf6477b"
			pos_type = score_pos
			pos_off = (386.0, 382.0)
			pos_off_p2 = (386.0, 382.0)
			zoff = 15.1999998
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_allwaylit_4
			element_parent = HUD2D_score_lights_container
			texture = #"0x5cf6477b"
			pos_type = score_pos
			pos_off = (374.0, 362.0)
			pos_off_p2 = (374.0, 362.0)
			zoff = 15.1999998
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_light_allwaylit_5
			element_parent = HUD2D_score_lights_container
			texture = #"0x5cf6477b"
			pos_type = score_pos
			pos_off = (362.0, 342.0)
			pos_off_p2 = (362.0, 342.0)
			zoff = 15.1999998
			alpha = 0
			flags = {
				p2
			}
			Scale = 1.1799999
		}
		{
			element_id = HUD2D_score_nixie_1a
			element_parent = HUD2D_score_container
			texture = #"0xb373f287"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_2a
			element_parent = HUD2D_score_container
			texture = #"0x985ea144"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_2b
			element_parent = HUD2D_score_container
			texture = #"0x0157f0fe"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_3a
			element_parent = HUD2D_score_container
			texture = #"0x81459005"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_4a
			element_parent = HUD2D_score_container
			texture = #"0xce0406c2"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_4b
			element_parent = HUD2D_score_container
			texture = #"0x570d5778"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_6b
			element_parent = HUD2D_score_container
			texture = #"0x653b35fa"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			element_id = HUD2D_score_nixie_8b
			element_parent = HUD2D_score_container
			texture = #"0xfbb81874"
			pos_type = score_pos
			pos_off = (342.0, 362.0)
			zoff = -3
			alpha = 0
		}
		{
			parent_container
			element_id = HUD2D_note_container
			pos_type = counter_pos
			note_streak_bar
			pos_off = (0.0, 0.0)
		}
		{
			element_id = HUD2D_counter_body
			element_parent = HUD2D_note_container
			texture = #"0x38b63489"
			pos_off = (0.0, 0.0)
			zoff = 4
		}
		{
			element_id = #"0x4020ac1b"
			element_parent = HUD2D_note_container
			texture = #"0x4020ac1b"
			pos_off = (4.0, 40.0)
			zoff = 8
		}
		{
			element_id = HUD2D_counter_drum_icon
			element_parent = HUD2D_note_container
			texture = None
			pos_off = (44.0, 40.0)
			zoff = 26
		}
		{
			element_id = HUD2D_score_flash
			element_parent = HUD2D_score_container
			texture = #"0x36f7ff86"
			just = [
				center
				center
			]
			pos_type = score_pos
			pos_off = (128.0, 128.0)
			zoff = 20
			alpha = 0
		}
		{
			element_id = #"0x0500c035"
			element_parent = HUD2D_score_container
			texture = white
			just = [
				left
				center
			]
			pos_off = (-12.0, 84.0)
			dims = (256.0, 6.0)
			zoff = 28
			alpha = 1
			rgba = [
				196
				169
				65
				255
			]
		}
		{
			element_id = #"0xddc6125f"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_line
			just = [
				left
				center
			]
			pos_off = (-13.0, 89.0)
			dims = (256.0, 12.0)
			zoff = 3
			Scale = 1.7
		}
		{
			element_id = #"0x4ae39f0b"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_cursor
			just = [
				0.7
				0.5
			]
			zoff = 29
			blend = add
			Scale = 0.9
		}
		{
			element_id = #"0x95a37ec5"
			element_parent = HUD2D_score_container
			texture = white
			just = [
				left
				center
			]
			pos_off = (-17.0, 28.0)
			dims = (267.0, 6.0)
			zoff = 4
			alpha = 1
			rgba = [
				70
				125
				196
				255
			]
		}
		{
			element_id = #"0x3693c461"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_line
			just = [
				left
				center
			]
			pos_off = (-17.0, 33.0)
			dims = (267.0, 12.0)
			zoff = 3
			Scale = 1.65
		}
		{
			element_id = #"0x766026d8"
			element_parent = HUD2D_score_container
			texture = HUD_progbar_cursor
			just = [
				0.7
				0.5
			]
			zoff = 6
			blend = add
			Scale = 0.9
		}
		{
			parent_container
			element_id = #"0xf1b083bb"
			element_parent = HUD2D_score_container
			pos_off = (220.0, 15.0)
		}
		{
			element_id = #"0xad82033a"
			element_parent = #"0xf1b083bb"
			texture = #"0x65aaa809"
			alpha = 1
			zoff = 20
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0xda8533ac"
			element_parent = #"0xf1b083bb"
			texture = #"0x12ad989f"
			alpha = 0
			zoff = 21
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0x438c6216"
			element_parent = #"0xf1b083bb"
			texture = #"0x8ba4c925"
			alpha = 0
			zoff = 22
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0x348b5280"
			element_parent = #"0xf1b083bb"
			texture = #"0xfca3f9b3"
			alpha = 0
			zoff = 23
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0xaaefc723"
			element_parent = #"0xf1b083bb"
			texture = #"0x62c76c10"
			alpha = 0
			zoff = 24
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0xdde8f7b5"
			element_parent = #"0xf1b083bb"
			texture = #"0x15c05c86"
			alpha = 0
			zoff = 25
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
		{
			element_id = #"0x3a74478c"
			element_parent = #"0xf1b083bb"
			texture = #"0xd92726ac"
			alpha = 1
			zoff = 30
			pos_off = (-15.0, -26.0)
			Scale = 1.4
		}
	]
}
