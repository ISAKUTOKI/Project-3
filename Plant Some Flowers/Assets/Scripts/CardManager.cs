using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

/// <summary>
/// 卡牌管理器，负责管理所有卡牌的状态，包括：
/// 手中的卡牌;
/// 打出的卡牌;
/// 全卡牌列表;
/// </summary>
public class CardManager : MonoBehaviour
{
    public static CardManager instance;
    List<CardBehaviour> holdingCards = new List<CardBehaviour>();
    List<CardBehaviour> discardCards = new List<CardBehaviour>();

    public void AddToHoldingCards(Card targetCard)
    {

    }

    // 对全部卡牌进行定义
    public enum AllCards
    {
        种植,
        浇水,
        施肥,
        修剪,
        收获,
    }
}
