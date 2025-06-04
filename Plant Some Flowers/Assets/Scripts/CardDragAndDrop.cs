using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 在这里处理抓放的效果
/// ！！！不负责处理鼠标的位置检测
/// </summary>
public class CardDragAndDrop : MonoBehaviour
{
    bool isDragging = false;
    Vector3 offset;
    bool isOnTarget = false;
    private void Update()
    {
        if (!CardBehaviour.instance.mouseIsInArea)
            return;
        if (Input.GetMouseButtonDown(0)) // 鼠标左键按下
        {
            StartDrag();
        }
        else if (Input.GetMouseButtonUp(0)) // 鼠标左键释放
        {
            StopDrag();
        }
        else if (Input.GetMouseButtonDown(1)) // 鼠标右键按下
        {
            StopDrag();
        }

        if (isDragging)
        {
            Drag();
        }
    }

    // 处理抓起的逻辑
    void StartDrag()
    {
        isDragging = true;
    }
    // 处理放下的逻辑
    void StopDrag()
    {
        isDragging = false;

        if (isOnTarget)
        {
            // 产生效果
            Debug.Log("卡牌生效");
            CardBehaviour.instance.PlayCard();
        }
        else
        {
            // 放回原位
            Debug.Log("无目标，卡牌回到原位");
            BackToOriginalPos();
        }
    }

    // 拖动的实现
    void Drag()
    {
        Vector3 mousePosition = Input.mousePosition;
        mousePosition.z = Camera.main.nearClipPlane;
        Vector3 worldPosition = Camera.main.ScreenToWorldPoint(mousePosition) + offset;
        transform.position = worldPosition;
    }// 只是先放在这里的一个占位，还没有完全实现

    void BackToOriginalPos()
    {

    }
}
