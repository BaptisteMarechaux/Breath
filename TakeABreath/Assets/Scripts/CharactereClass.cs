﻿using UnityEngine;
using System.Collections;


public class CharactereClass : MonoBehaviour {

    [SerializeField]
    private string _name;
    [SerializeField]
    private int _level = 1;
    [SerializeField]
    private int _intelligence = 5;
    [SerializeField]
    private int _exp = 0;
    [SerializeField]
    private int _expToLvlUp = 50;
    [SerializeField]
    MonsterClass _monstrePossede;

    private void levelUp()
    {
        //faire apparaitre à l'écran une fenêtre pour choisir les stats à up (5-7 points dispo pour up)
        this._level++;
        this._exp = this._exp % this._expToLvlUp;
        this._expToLvlUp *= 2;
        this._intelligence++;
    }


    public string Name
    {
        get
        {
            return _name;
        }

        set
        {
            _name = value;
        }
    }

    public int Level
    {
        get
        {
            return _level;
        }

        set
        {
            _level = value;
        }
    }

    public int Intelligence
    {
        get
        {
            return _intelligence;
        }

        set
        {
            _intelligence = value;
        }
    }

    public int addExp(int exp)
    {
        this._exp += exp;
        if(this._exp >= this._expToLvlUp)
        {
            levelUp();
            return this._level;
        }
        return 0;
    }

    public void essaiPossession(MonsterClass monster)
    {
        if(this._intelligence > monster.Intelligence)
        {
            this._monstrePossede = monster;
            monster.Player = this;
        }
    }


}


