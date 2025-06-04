using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CardController : MonoBehaviour
{
    public static CardController instance;
    public Card newCard = null;

    void GetOneRandomCard()
    {
        int randomCount = Random.Range(0, 1);// 长度还没写，记得写一下
    }
    void DrawNewCard()
    {
        CardManager.instance.AddToHoldingCards(newCard);
        // 这里可以添加逻辑来抽取新卡
        Debug.Log("抽取新卡牌");
    }

}
