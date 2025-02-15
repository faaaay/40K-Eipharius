/* Weapons
 * Contains:
 * Classic Baton
 * Telebaton
 */

/*
 * Classic Baton
 */
/obj/item/melee/classic_baton
	name = "police baton"
	desc = "A truncheon for beating criminal scum."
	icon = 'icons/obj/weapons/melee/misc.dmi'
	icon_state = "baton"
	item_state = "EB-shaft"
	slot_flags = SLOT_BELT
	force = 22
	block_chance = 15
	parry_sounds = list('sound/weapons/blunt_parry1.ogg', 'sound/weapons/blunt_parry2.ogg', 'sound/weapons/blunt_parry3.ogg')

/obj/item/melee/classic_baton/handle_shield(mob/living/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(default_sword_parry(user, damage, damage_source, attacker, def_zone, attack_text))
		return 1
	return 0
/*
/obj/item/melee/classic_baton/attack(mob/M as mob, mob/living/user as mob)
	if ((CLUMSY in user.mutations) && prob(50))
		to_chat(user, "<span class='warning'>You club yourself over the head.</span>")
		user.Weaken(3 * force)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(2*force, BRUTE, BP_HEAD)
		else
			user.take_organ_damage(2*force)
		return
	return ..()
*/


//Telescopic baton
/obj/item/melee/telebaton
	name = "telescopic baton"
	desc = "A compact yet rebalanced personal defense weapon. Can be concealed when folded."
	icon = 'icons/obj/weapons/melee/misc.dmi'
	icon_state = "telebaton_0"
	item_state = "telebaton_0"
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_SMALL
	force = 5
	var/on = 0


/obj/item/melee/telebaton/attack_self(mob/user as mob)
	on = !on
	if(on)
		user.visible_message("<span class='warning'>With a flick of their wrist, [user] extends their telescopic baton.</span>",\
		"<span class='warning'>You extend the baton.</span>",\
		"You hear an ominous click.")
		icon_state = "telebaton_1"
		item_state = "nullrod"//was teletbaton_1 but guess what... that icon doesn't exist
		w_class = ITEM_SIZE_NORMAL
		force = 20//quite robust
		attack_verb = list("smacked", "struck", "slapped")
	else
		user.visible_message("<span class='notice'>\The [user] collapses their telescopic baton.</span>",\
		"<span class='notice'>You collapse the baton.</span>",\
		"You hear a click.")
		icon_state = "telebaton_0"
		item_state = "telebaton_0"//lmao these item_state icons don't even exist
		w_class = ITEM_SIZE_SMALL
		force = 0//not so robust now
		attack_verb = list("hit", "punched")

	update_held_icon()

	playsound(src.loc, 'sound/weapons/empty.ogg', 50, 1)
	add_fingerprint(user)

	if(blood_overlay && blood_DNA && (blood_DNA.len >= 1)) //updates blood overlay, if any

		overlays.Cut()//this might delete other item overlays as well but eeeeeeeh

		var/icon/I = new /icon(src.icon, src.icon_state)
		I.Blend(new /icon('icons/effects/blood.dmi', COLOR_BLOOD_HUMAN, ICON_ADD))//rgb(255,255,255)),ICON_ADD)
		I.Blend(new /icon('icons/effects/blood.dmi', "itemblood"),ICON_MULTIPLY)
		blood_overlay = I

		overlays += blood_overlay

	return

/obj/item/melee/classic_baton/crozius
	name = "crozius arcanum"
	desc = "A Crozius Arcanum is a mace or staff that is used as both a melee weapon and the primary badge of office of Space Marine Chaplains."
	icon = 'icons/obj/weapons/melee/misc.dmi'
	icon_state = "crozius"
	item_state = "crozius"
	force = 30 //in conjunction with ass tardes str this thing is insane
	armor_penetration = 70
	throwforce = 1
	throw_speed = 1
	throw_range = 1
	str_requirement = 25
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("crushes", "strikes", "bashes", "pounds")