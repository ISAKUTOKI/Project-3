using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;

/// <summary>
/// 单个卡牌单位的总控制
/// </summary>
public class CardBehaviour : MonoBehaviour
{
    public static CardBehaviour instance;

    [SerializeField] private Card cardData;
    SpriteRenderer cardRenderer;

    // 组件引用
    private void Awake()
    {
        instance = this;
        this.tag = "Card";
        cardRenderer = GetComponentInChildren<SpriteRenderer>();
    }

    // 合法性检测与初始化
    private void Start()
    {
        if (cardData == null)
        {
            Debug.LogError("卡牌数据未设置");
            return;
        }
        else
        {
            InitializeCard();
        }
    }

    // 初始化卡牌
    void InitializeCard()
    {
        SetCardImage();
    }
    void SetCardImage()
    {
        if (cardData.cardImage == null)
        {
            Debug.LogError("没有设置正确的卡牌图片");
        }
        else
        {
            cardRenderer.sprite = cardData.cardImage;
        }
    }

    // 使用卡牌
    public List<IEffect> Effect;// 由卡牌类型决定
    public void PlayCard()
    {
        foreach (var effect in Effect)
        {
            effect.Resolve();
        }
    }

    // 销毁卡牌
    bool isDestroyed = false;
    public void DestroyThisCard()
    {
        isDestroyed = true;
    }

    // 切换鼠标在卡牌上的状态
    public bool mouseIsInArea = false;
    private void MouseIsInArea()
    {
        if (!isDestroyed)
        {
            mouseIsInArea = true;
        }
    }
    private void MouseIsOutArea()
    {
        mouseIsInArea = false;
    }
}
